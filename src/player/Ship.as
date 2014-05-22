package player 
{
	import data.ILevel;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.media.Video;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	import land.Game;
	import math.shapes.BasicShape;
	import math.shapes.Circle;
	import math.shapes.Line;
	import math.Vector2D;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Ship extends Sprite 
	{		
		private var _controlEnabled:Boolean = true;
		
		private var _fuel:Number;
		
		private var controller:IController;
		
		private var thrust:Number = 0;
		
		private var _velocity:Vector2D;
		private var _gravity:Number;
		
		private var _angleRadians:Number = 0;
		private var _angleDegrees:Number = 0;
		
		private var _shapes:Vector.<BasicShape>;
		
		private var _burstUsed:Number = 0;
		
		private var _updated:Boolean;
		
		private var _position:Point;
		/**
		 * TODO NEED TO DOCUMENT THIS CLASS BETTER
		 * @param	controller
		 */
		public function Ship(controller:IController) 
		{
			this.controller = controller;
			
			this.controller.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			_velocity = new Vector2D(0,0);
			
			_shapes = new Vector.<BasicShape>();					
			_shapes.push(new Circle(6));			
			_shapes.push(new Line(new Point(3, 7), new Point(2, 2)));
			_shapes.push(new Line(new Point(-3, 7), new Point(-2, 2)));
			_shapes.push(new Line(new Point(4, 6), new Point( -4, 6)));
			
			_fuel = Config.START_FUEL;
		}	
		
		public function reset():void
		{
			controlEnabled = true;
			_updated = false;
			_fuel = Config.START_FUEL;
			_burstUsed = 0;
		}
		
		public function setBeginValues(level:ILevel):void
		{
			controlEnabled = true;
			
			_position = level.startLocation.clone();
			this.x = _position.x;
			this.y = _position.y;
			
			
			_updated = false;
			_burstUsed = 0;
			_gravity = level.gravity;
			_angleDegrees = level.startRotation;
			this.rotation = _angleDegrees;
			_angleRadians = 90 * Math.PI / 180;
			
			for (var i:int = 0; i < _shapes.length; i++)
			{
				_shapes[i].rotation = _angleRadians;
			}
			
			this.thrust = 1;
			_velocity.y = 0.1;
			_velocity.x = 0.2;
		}
		
		public function drawShip():void
		{
			graphics.clear();
			
			//circle
			graphics.lineStyle(0.2, 0xFFFFFF);
			graphics.drawCircle(0, 0, 4);
			
			//right diagonal line
			graphics.moveTo(2, 2);
			graphics.lineTo(4, 5);
			
			//left diagonal line
			graphics.moveTo(-2, 2);
			graphics.lineTo( -4, 5);
			
			//middle line
			graphics.moveTo( -3.2, 4);
			graphics.lineTo(3.2, 4);
			
			//thrust triangle
			graphics.moveTo( -2, 5);
			graphics.lineTo( 0, thrust * 20 + 5);
			graphics.lineTo(2, 5);
			
			// Debug code for collision
			if (Config.DEBUG && Game.DEBUG)
			{
				for (var i:int = 0; i < _shapes.length; i++)
				{
					_shapes[i].debug(Game.DEBUG, new Point(this.x, this.y));
				}
			}
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			if (!_controlEnabled) return;
			var i:int;
			if (e.keyCode == Keyboard.UP && fuel > 0)
			{
				if (thrust < 1)
				{
					thrust += 0.1;
					if (this.thrust > 1)
					{
						this.thrust = 1;
					}
				}				
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				if (thrust > 0)
				{
					thrust -= 0.1;
					if (this.thrust < 0)
					{
						this.thrust = 0;
					}
				}		
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				//if (rotation < 90)
				{
					_angleDegrees += 10;
					_angleDegrees = _angleDegrees % 360;
					_angleRadians = _angleDegrees * Math.PI / 180;
					for (i = 0; i < _shapes.length; i++)
					{
						_shapes[i].rotation = _angleRadians;
					}
				}
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				//if (rotation > -90)
				{
					_angleDegrees -= 10;
					_angleDegrees = _angleDegrees % 360;
					_angleRadians = _angleDegrees * Math.PI / 180;					
					for (i = 0; i < _shapes.length; i++)
					{
						_shapes[i].rotation = _angleRadians;
					}
				}
			}
			if (e.keyCode == Keyboard.SPACE && _updated == true && _burstUsed == 0)
			{
				_burstUsed = getTimer();
				thrust = 2.5;
			}
		}
		
		public function update():void
		{			
			if (_updated == false)
			{
				_updated = true;
			}
			
			updateVelocity();		
			updateBurst();
			updateFuel();
			
			SoundManager.instance.changeThrustVolume(thrust);
			
			_position.x += _velocity.x;
			_position.y += _velocity.y;
			
			this.x = _position.x;
			this.y = _position.y;
			this.rotation = _angleDegrees;
			
			
			drawShip();
		}
		
		private function updateVelocity():void 
		{
			if (thrust > 0)
			{
				_velocity.x += (thrust * Config.THRUST_CONSTANT) * Math.sin(angleRadians);
				_velocity.y -= (thrust * Config.THRUST_CONSTANT) * Math.cos(angleRadians);
			}
			
			_velocity.y += _gravity;
			_velocity.x *= Config.DRAG;
			
			if (this.velocity.x > Config.TOP_SPEED)
			{
				this.velocity.x = Config.TOP_SPEED;
			}
			if (this.velocity.y > Config.TOP_SPEED)
			{
				this.velocity.y = Config.TOP_SPEED;
			}
		}
		
		private function updateBurst():void
		{
			if (_burstUsed != 0 && _burstUsed + Config.BURST_LENGTH > getTimer())
			{
				if (_angleDegrees > 0)
				{
					_angleDegrees -= Math.random() * 10;
				}
				else
				{
					_angleDegrees += Math.random() * 10;
				}
				
				_angleRadians = _angleDegrees * Math.PI / 180;
			}
			if (thrust > 1 && _burstUsed + Config.BURST_LENGTH < getTimer())
			{
				thrust -= 0.05;
				_angleDegrees = 0;
				_angleRadians = _angleDegrees * Math.PI / 180;
			}
		}
		
		private function updateFuel():void
		{
			if (this.fuel <= 0 && this.thrust != 0)
			{
				if (this.thrust > 0)
				{
					this.thrust -= 0.05;
				}
				if (this.thrust < 0.05)
				{
					this.thrust = 0;
				}
			}
			else
			{
				_fuel -= thrust * 0.2;
			}
		}
		
		public function get shapes():Vector.<BasicShape> 
		{
			return _shapes;
		}
		
		
		
		public function get angleDegrees():Number 
		{
			return _angleDegrees;
		}		
		public function get angleRadians():Number 
		{
			return _angleRadians;
		}
		
		public function get velocity():Vector2D 
		{
			return _velocity;
		}
		
		public function get fuel():int 
		{
			return _fuel;
		}
		
		/**
		 * Disable controls and remove thrust and add aditional gravity to make a crash certain
		 */
		public function set controlEnabled(value:Boolean):void 
		{
			_controlEnabled = value;
			thrust = 0;
			_gravity = 0.1;
		}
		
		public function get position():Point 
		{
			return _position;
		}
	}
}