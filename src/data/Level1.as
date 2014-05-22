package data 
{
	import data.ILevel;
	import editor.LinePoint;
	import flash.geom.Point;
	import land.Game;
	import math.shapes.Circle;
	import math.shapes.Line;
	import math.Vector2D;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Level1 implements ILevel
	{
		private var _data:Vector.<Point>;
		private var _lines:Vector.<Line>;
		
		private var _gravity:Number = 0.0005;
		private var _startRotation:Number = 90;
		private var _startVelocity:Vector2D = new Vector2D(0.2, 0.1);
		private var _startLocation:Point = new Point(110, 110);
		private var _timeScore:Number = 1000;
		private var _landScore:Number = 500;
		private var _color:Number = 0xFFFFFF;
		private var _landColor:Number = 0x000000;
		
		public function Level1() 
		{
			_lines = new Vector.<Line>();
			
			var i:int = 0;
			
			_data = Vector.<Point>([/*START_POINTS*/
			new Point(-0.5, 455), 
new Point(13, 450), 
new Point(30, 440), 
new Point(41, 430), 
new Point(49, 418), 
new Point(52, 405), 
new Point(66, 390), 
new Point(80, 392), 
new Point(90, 409), 
new Point(98, 424), 
new Point(114, 428), 
new Point(142, 428), 
new Point(148, 420), 
new Point(151, 410), 
new Point(154, 401), 
new Point(176, 400), 
new Point(214, 400), 
new Point(222, 416), 
new Point(232, 430), 
new Point(244, 445), 
new Point(261, 461), 
new Point(318, 461), 
new Point(335, 464), 
new Point(349, 471), 
new Point(388, 463), 
new Point(407, 456), 
new Point(426, 448), 
new Point(455, 448), 
new Point(468, 430), 
new Point(482, 415), 
new Point(493, 401), 
new Point(508, 394), 
new Point(524, 386), 
new Point(542, 379), 
new Point(560, 378), 
new Point(587, 386), 
new Point(599.5, 399) 

			/*END_POINTS*/]);
			
			var prependArray:Vector.<Point> = _data.slice(0, _data.length);
				for (i = 0; i < prependArray.length; i++)
				{
					prependArray[i] = prependArray[i].clone();
					prependArray[i].x = -prependArray[i].x
				}
				
			var appendArray:Vector.<Point> = _data.slice(0, _data.length);
				for (i = 0; i < appendArray.length; i++)
				{
					appendArray[i] = appendArray[i].clone();
					appendArray[i].x = (605 - appendArray[i].x) + 605;
				}
				
			_data.reverse();		
			_data = _data.concat(prependArray);
			_data.reverse();
			
			appendArray.reverse();
			_data = _data.concat(appendArray);
			
			for (i = 0; i < _data.length -1; i += 1)
			{
				_lines.push(new Line(_data[i+1], _data[i]));
			}
		}
		
		public function getLinesIn(x:Number, y:Number, radius:Number):Vector.<Line>
		{
			var tempLines:Vector.<Line> = new Vector.<Line>();
			
			var circle:Circle = new Circle(radius, x, y);
				
			if (Config.DEBUG && Game.DEBUG)
			{
				circle.debug(Game.DEBUG);
			}
			
			for (var i:int; i < _lines.length; i++)
			{
				if (circle.containsOrIntersectsLine(lines[i]) == true)
				{
					if (Config.DEBUG && Game.DEBUG)
					{
						_lines[i].debug(Game.DEBUG, new Point(0, -2));
					}
					
					tempLines.push(_lines[i]);
				}
			}
			return tempLines;
		}
		
		public function get data():Vector.<Point>
		{
			return _data;
		}
		
		public function get lines():Vector.<Line> 
		{
			return _lines;
		}
		
		
		public function get startLocation():Point
		{
			return _startLocation;
		}
		public function get startRotation():Number
		{
			return _startRotation
		}
		
		public function get gravity():Number 
		{
			return _gravity;
		}
		
		public function get startVelocity():Vector2D 
		{
			return _startVelocity;
		}
		
		public function get timeScore():int
		{
			return _timeScore;
		}
		public function get landScore():int
		{
			return _landScore;
		}
	}
}