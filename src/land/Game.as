package land 
{
	import data.CollisionObject;
	import data.ILevel;
	import data.OriginalLevel;
	import data.TestLevel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.net.SharedObject;
	import flash.utils.getTimer;
	import math.shapes.Line;
	import math.Vector2D;
	import player.controllers.KeyboardController;
	import player.HUD;
	import player.Ship;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Game extends Sprite 
	{		
		//DEBUG VARAIBLE
		public static var DEBUG:Sprite;	
		
		//the level we are currently playing (from the Config.LEVELS array)
		private var _currentLevel:int;
		
		//level landscape we are assigned to (should always contain Config.LEVELS[_currentLevel])
		private var _level:Landscape;
		
		//current score of the game
		private var _score:Number;
		
		//2 message objects one for the centered large messages and one for small messages when zoomed in
		private var _message:Message;
		private var _smallMessage:Message;
		
		//ship we are controlling
		private var _ship:Ship;
		
		//current state of the game to handle key presses
		private var _state:String;
		
		private var _hud:HUD;
		
		//check which time the state is changed so we don't press a key multiple times and change the state too fast
		private var _stateChanged:int;
		
		//currently unaivable
		//private var _dust:Dust;
		
		/**
		 * Constructer
		 * @param	hud
		 */
		public function Game(hud:HUD) 
		{
			//set game start variables
			_currentLevel 	= Config.START_LEVEL;
			_score 			= Config.START_SCORE;
			_stateChanged	= 0;
			_hud 			= hud;	
			
			DEBUG = this;
			
			//initialize objects	
			//_dust 					= new Dust();
			_message 				= new Message(18);
			_smallMessage 			= new Message(6);
			_smallMessage.visible 	= false;
			
			//wait for added on stage
			addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			//create the ship 
			_ship = new Ship(new KeyboardController(stage));
			addChild(_ship);
			
			addChild(_message);			
			addChild(_smallMessage);
			//addChild(_dust);
			
			//reset the game to correct state and reset variables
			reset();
			
			//handle all key presses
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		/**
		 * Key handler
		 * @param	e
		 */
		private function onKey(e:KeyboardEvent):void 
		{
			//if the state is changed within a second ago don't change it again (it will happen to fast then)
			if (_stateChanged + 1000 > getTimer())
			{
				return;
			}
			
			//check which state we are and what to do on a key press
			switch(_state)
			{
				case GameState.START_LEVEL:
					startLevel(); 	//start a new level
				break;
				case GameState.RESTART_GAME:
					reset();		//restart the game
				break;
				case GameState.NEXT_LEVEL:
					//next level counter
					_currentLevel++;
					
					//if we are passed all level start over again (will run out fuel anytime
					if (_currentLevel > Config.LEVELS.length -1)
					{
						_currentLevel = 0;
					}			
					//build the level
					buildLevel(Config.LEVELS[_currentLevel]);
					//and start it
					startLevel();
				break;
			}
		}
		
		/**
		 * Reset the game
		 */
		private function reset():void 
		{
			//set the state of beginning a level
			_state = GameState.START_LEVEL;
			
			//scale the game correctly
			this.scaleY = this.scaleX = 1;
			this.x = 0;
			this.y = 0;
			
			//save the score to a cookie if we had any
			if (_score > 0)
			{
				var mySharedObject:SharedObject = SharedObject.getLocal("LunarLanderRemake");
				
				if (!mySharedObject.data.highScore || _score > mySharedObject.data.highScore)
				{
					mySharedObject.data.highScore = _score.valueOf();
				}
				mySharedObject.flush();
			}
			_score = 0;
			
			//reset hud and ship
			_hud.reset();
			_ship.reset();
			
			//set it to the start level (probally zero)
			_currentLevel = Config.START_LEVEL;
			
			//if we already had a landscape level created destroy it and remove it from the memory
			if (_level != null)
			{
				_level.destroy();
				removeChild(_level);
				_level = null;
			}			
			
			//create first level to view on the background
			buildLevel(Config.LEVELS[_currentLevel]);
			
			//add start message on the screen
			_message.changeText(Config.START_MESSAGE, Config.EXTRA_START_MESSAGE);
			_message.center();
		}
		
		/**
		 * Start a new level
		 */
		public function startLevel():void
		{
			//remove all messages
			_message.visible = false;
			//set state to playing
			_state = GameState.PLAY_LEVEL;			
			//update the level
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * Update function for the level
		 * @param	e
		 */
		private function update(e:Event):void 
		{
			if (Config.DEBUG) graphics.clear();
			
			//update the level (moving stars etc)
			_level.update();
			//update ship (setting new position and velocity)
			_ship.update();
			//check if we need to zoom in or out
			updateZoom();
			//check all collision that happend and respond to them
			checkCollision();
			//drawStarDust();
			
			//update the hud (ugly cookie code)
			var mySharedObject:SharedObject = SharedObject.getLocal("LunarLanderRemake");
			var highScore:int = mySharedObject.data.highScore;
			_hud.update(_score, _level.time, _ship.fuel, _ship.y, _ship.velocity.x, _ship.velocity.y, highScore);
		}
		
		//TODO NOT USED ATM still need to implement
		/*private function drawStarDust():void 
		{
			var lines:Vector.<Line> = _level.nearLines;
			
			var rotation:Vector2D = new Vector2D(1, 1);
				rotation = rotation.normalize;
				rotation.rotation = _ship.rotation;
				
			for (var i:int; i < lines.length; i++)
			{				
				if (rotation.intersectToLine(lines[i], _ship.position) != null)
				{
					if (Config.DEBUG && Game.DEBUG)
					{
						lines[i].debug(Game.DEBUG, lines[i].vector.lNormal.scale(2).toPoint(), 0xFFFF00);
					}
					var centerOfLine:Point = Point.interpolate(lines[i].A, lines[i].B, 0.5);
					_dust.x = centerOfLine.x;
					_dust.y = centerOfLine.y;
				}
			}			
		}*/
		
		/**
		 * Check fo all collision to the level
		 */
		private function checkCollision():void 
		{
			//retrieve all collision objects
			var collisions:Vector.<CollisionObject> = _level.checkCollision(_ship);
			
			//if we had collision
			if (collisions.length > 0)
			{
				//stop updating
				removeEventListener(Event.ENTER_FRAME, update);
				
				//loop through all collisions
				for each(var collision:CollisionObject in collisions)
				{			
					//debug code to drag collision lines in red
					if (Config.DEBUG)
					{
						graphics.beginFill(0xFF0000, 0.2);
						graphics.drawCircle(collision.hit.x, collision.hit.y, 2);
						graphics.endFill();
						graphics.lineStyle(4, 0xFF0000, 0.5);
						graphics.moveTo(collision.line.x, collision.line.y);
						graphics.lineTo(collision.line.B.x, collision.line.B.y);
					}
					
					//if the collision happend on a flat line
					if (collision.line.y == collision.line.B.y)
					{
						//if ship was rotated we crashed
						if (_ship.rotation > 0)
						{
							state = GameState.CRASHED_ROTATED;
						}
						//if we go to fast we crashed
						else if (_ship.velocity.y > 0.2)
						{
							state = GameState.CRASHED_TOO_FAST;
						}
						//else we landed correctly
						else
						{
							state = GameState.LANDED;
						}
					}
					else
					{
						//we crashed on a not flat line
						state = GameState.CRASHED_NOT_FLAT;
					}
					break;
				}
				
				//stop playing thrust sounds
				SoundManager.instance.changeThrustVolume(0);
				
				//if we landed
				if (_state == GameState.LANDED)
				{					
					//get land score based on how fast we did the level and how fast we landed
					var landingScore:int = Math.abs(Config.LEVELS[_currentLevel].timeScore - (_level.time / 100)) + ((0.2 - _ship.velocity.y) * Config.LEVELS[_currentLevel].landScore);
					
					//check if the line was a multiplier landzone
					var zone:Landzone = _level.isLandZone(collision.line);
					
					//if it was a multiplier landzone multiply the score
					if (zone)
					{
						landingScore *= zone.multiplier;
					}
					
					//add the level score to game score
					_score += landingScore;
					
					//change message 
					_smallMessage.changeText(Config.LANDED_TEXT, "SCORED: " + landingScore + "\n" + Config.NEXT_LEVEL);
					_smallMessage.visible = true;
					_smallMessage.x = _ship.x - _smallMessage.width / 2;
					_smallMessage.y = _ship.y + 50;
					//change gamestate
					state = GameState.NEXT_LEVEL;
				}
				if (_state == GameState.CRASHED_NOT_FLAT || _state == GameState.CRASHED_ROTATED || _state == GameState.CRASHED_TOO_FAST)
				{			
					//we crashed show message
					_smallMessage.changeText(Config.CRASH_TEXT(_state), Config.RESTART + "\n score:" + _score);
					_smallMessage.visible = true;
					_smallMessage.x = _ship.x - _smallMessage.width/2;
					_smallMessage.y = _ship.y + 50;
					
					//change gamestate to restart
					state = GameState.RESTART_GAME;
				}
			}
			
			//if ship is going out of bounds
			if (_ship.x < -10 || _ship.x > 610 || _ship.y < -30)
			{				
				//prevent controling ship (still need alien shooting ship down)
				_ship.controlEnabled = false;
				
				//if we went out of the gravity
				if (_ship.y < -30)
				{
					removeEventListener(Event.ENTER_FRAME, update);
					
					_message.changeText(Config.NO_GRAVITY, Config.RESTART);
					_message.center();
					
					_state = GameState.RESTART_GAME;
				}
				else
				{
					//if we got out of x bounds show a message and scroll screen to show the ship crashing down
					_message.changeText(Config.OUT_OF_BOUNDS, Config.RESTART);
					_message.center();
					
					this.x = - (_ship.x - 600) - 300;
					this.y = 0;
					scaleX = scaleY = 1;
					_message.x += 300;
				}
				
				SoundManager.instance.changeThrustVolume(0);
			}
		}
		
		/**
		 * Zoom ship based on how the attidue is
		 */
		private function updateZoom():void
		{
			if (_ship.y < 250)
			{
				this.scaleY = this.scaleX = 1;
				this.x = 0;
				this.y = 0;
			}
			else
			{
				this.scaleY = this.scaleX = 2;
				this.x = ( -_ship.x) * 2 + 600 / 2;
				this.y = ( -_ship.y) * 2 + 480 /2;
			}
		}
		
		/**
		 * Build a level based on a ILevel template
		 * @param	level
		 */
		private function buildLevel(level:ILevel):void
		{
			//remove any levels if there are any left
			if (_level != null)
			{
				_level.destroy();
				removeChild(_level);
			}
			
			//hide small messages
			_smallMessage.visible = false;
			
			//change game state to start
			state = GameState.START_LEVEL;
			
			//create the new landscape and draw it
			_level = new Landscape(level);
			_level.drawLevel();
			
			//set ship begin values based on level and draw the ship
			_ship.setBeginValues(level);
			_ship.drawShip();
			
			//add the level before the smallmessage index
			addChildAt(_level, getChildIndex(_smallMessage)-1);
		}
		
		/**
		 * Each time we change the state of this game we save the time it was done
		 */
		private function set state(value:String):void 
		{
			_stateChanged = getTimer();
			_state = value;
		}
	}
}