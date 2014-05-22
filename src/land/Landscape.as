package land
{
	import data.CollisionObject;
	import data.ILevel;
	import flash.display.FrameLabel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import math.shapes.BasicShape;
	import math.shapes.Line;
	import player.Ship;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Landscape extends Sprite
	{		
		//level template
		private var _level:ILevel;
		
		//lines that are collision possible
		private var _nearLines:Vector.<Line>;
		
		//start time of this level
		private var _startTime:Number;
		
		//stars in this level
		private var _stars:Vector.<Star>;
		
		//here we draw the mountains lines so we can still use graphics on this sprite
		private var _mountains:Sprite;
		
		//possible landzones we calculate dynamicly
		private var _landZones:Vector.<Landzone> = new Vector.<Landzone>();
		
		public function Landscape(level:ILevel) 
		{
			//init variables
			_startTime = getTimer();
			_level = level;
			_stars = new Vector.<Star>();
			_mountains = new Sprite();
		}
		
		/**
		 * Draw the level based on ILevel templat epoints
		 */
		public function drawLevel():void
		{
			_mountains.graphics.beginFill(0);
			_mountains.graphics.lineStyle(1, 0xFFFFFF);
			
			_mountains.graphics.moveTo(_level.data[0].x, _level.data[0].y);
			
			//draw all lines
			for (var i:int = 1; i < _level.data.length; i++)
			{
				_mountains.graphics.lineTo(_level.data[i].x, _level.data[i].y);
			}
			
			//draw to lines down at the begin and end so we can fill it with black (prevents stars to go through the mountains)
			_mountains.graphics.lineTo(_level.data[_level.data.length - 1].x, 600);
			_mountains.graphics.lineTo(_level.data[0].x, 600);
			
			//create 100 Stars  they will update themself
			for (i = 0; i < 100; i++)
			{
				var star:Star = new Star();
					star.x = Math.random() * (600*3) - 600;
					star.y = Math.random() * 480;
				_stars[i] = star;
				addChild(star);
			}
			
			//add the mountains
			addChild(_mountains);
			
			//calculate possible landzones
			var possibleLandZones:Vector.<Line> = new Vector.<Line>();
			for (i = 0; i < _level.lines.length; i++)
			{
				if (_level.lines[i].y == _level.lines[i].B.y && _level.lines[i].xLength > 5 
					&& _level.lines[i].x > 0 && _level.lines[i].x < 600)
				{
					possibleLandZones.push(_level.lines[i]);
				}
			}
			possibleLandZones = possibleLandZones.sort(sortLandzones);
			
			//the smallest landzones will be choosen sorted by length
			for (i = 0; i < possibleLandZones.length; i++)
			{
				var landZone:Landzone = new Landzone(possibleLandZones[i], i + 1);		
				
				graphics.lineStyle(3, 0x00FF00, 0.3);
				graphics.moveTo(landZone.line.A.x, landZone.line.A.y);
				graphics.lineTo(landZone.line.B.x, landZone.line.B.y);
				
				_landZones.push(landZone);
				addChild(landZone.label);
			}
			possibleLandZones = null;
		}
		
		/**
		 * Check if given line is a landzone
		 * @param	line
		 * @return
		 */
		public function isLandZone(line:Line):Landzone
		{
			for (var i:int; i < _landZones.length; i++)
			{
				if (_landZones[i].line == line)
				{
					return _landZones[i];
				}
			}			
			return null;
		}
		
		/**
		 * Sort landzones by length
		 * @param	line
		 * @return
		 */
		private function sortLandzones(l1:Line, l2:Line):int
		{
			if (l1.xLength < l2.xLength)
			{
				return 1;
			}
			else if (l1.xLength > l2.xLength)
			{
				return -1
			}
			else
			{
				return 0;
			}
		}
		
		/**
		 * Update all stars
		 */
		public function update():void
		{
			for (var i:int = 0; i < _stars.length; i++)
			{
				_stars[i].update();
			}
		}
		
		/**
		 * Check for collisions to the ship
		 * @param	ship
		 * @return
		 */
		public function checkCollision(ship:Ship):Vector.<CollisionObject>
		{
			var closedPoint:Point = null;
			
			//get all lines in a circle of 30 around the ship
			_nearLines = _level.getLinesIn(ship.x, ship.y, 30);
			
			var objects:Vector.<CollisionObject> = new Vector.<CollisionObject>();
			
			//check each possible collision
			for each(var line:Line in _nearLines)
			{
				//check for each shape in the ship
				for each(var shape:BasicShape in ship.shapes)
				{
					//converts the shape coordinate system of its parent
					shape.x += ship.x;
					shape.y += ship.y;
					
					//check if the shape intersects with the line (mathematical
					var points:Vector.<Point> = line.intersects(shape);
					
					for each(var point:Point in points)
					{
						if (point == null)
						{
							continue;
						}
						else
						{
							//create collision objects
							var collision:CollisionObject = new CollisionObject();
								collision.hit = point;
								collision.shape = shape;
								collision.line = line;
							objects.push(collision);
						}
					}
					//converts the shape coordinate system back
					shape.x -= ship.x;
					shape.y -= ship.y;
				}
			}
			
			//return collisions
			return objects;
		}
		
		/**
		 * Destroy from memory
		 */
		public function destroy():void 
		{
			_mountains.graphics.clear();
			
			_landZones = null;
			
			for (var i:int; i < _stars.length; i++)
			{
				removeChild(_stars[i]);
				_stars[i] = null;
			}
			_stars = null;
			
			removeChild(_mountains);
		}
		
		/**
		 * Get time of this level 
		 */
		public function get time():Number
		{
			return getTimer() - _startTime;
		}
		
		/**
		 * Get lines that were possible collision (not used)
		 */
		public function get nearLines():Vector.<Line> 
		{
			return _nearLines;
		}
	}
}