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
	public class Level3 implements ILevel
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
		
		public function Level3() 
		{
			_lines = new Vector.<Line>();
			
			var i:int = 0;
			
			_data = Vector.<Point>([/*START_POINTS*/
			new Point(-0.5, 433), 
new Point(38, 432), 
new Point(46, 425), 
new Point(57, 411), 
new Point(63, 388), 
new Point(62, 373), 
new Point(51, 363), 
new Point(38, 356), 
new Point(37, 341), 
new Point(44, 330), 
new Point(54, 323), 
new Point(71, 319), 
new Point(98, 329), 
new Point(112, 343), 
new Point(106, 357), 
new Point(99, 368), 
new Point(87, 385), 
new Point(83, 401), 
new Point(89, 427), 
new Point(100, 435), 
new Point(113, 432), 
new Point(125, 429), 
new Point(140, 430), 
new Point(169, 430), 
new Point(200, 425), 
new Point(200, 370), 
new Point(240, 333), 
new Point(280, 369), 
new Point(280, 425), 
new Point(251, 425), 
new Point(250, 400), 
new Point(234, 400), 
new Point(235, 425), 
new Point(206, 425), 
new Point(293, 426), 
new Point(327, 432), 
new Point(390, 423), 
new Point(449, 423), 
new Point(456, 414), 
new Point(463, 403), 
new Point(474, 392), 
new Point(484, 380), 
new Point(496, 368), 
new Point(505, 361), 
new Point(532, 361), 
new Point(549, 359), 
new Point(566, 356), 
new Point(583, 360), 
new Point(600.5, 367) 

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