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
	public class Level2 implements ILevel
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
		
		public function Level2() 
		{
			_lines = new Vector.<Line>();
			
			var i:int = 0;
			
			_data = Vector.<Point>([/*START_POINTS*/
			new Point(-0.5, 422), 
new Point(8, 414), 
new Point(16, 407), 
new Point(22, 396), 
new Point(27, 387), 
new Point(31, 378), 
new Point(34, 368), 
new Point(35, 336), 
new Point(51, 308), 
new Point(58, 303), 
new Point(65, 300), 
new Point(73, 299), 
new Point(80, 297), 
new Point(82, 299), 
new Point(92, 297), 
new Point(98, 296), 
new Point(110, 298), 
new Point(118, 297), 
new Point(127, 296), 
new Point(137, 299), 
new Point(146, 305), 
new Point(154, 313), 
new Point(156, 322), 
new Point(150, 329), 
new Point(141, 337), 
new Point(132, 345), 
new Point(118, 351), 
new Point(110, 363), 
new Point(102, 380), 
new Point(103, 393), 
new Point(108, 404), 
new Point(118, 415), 
new Point(157, 415), 
new Point(163, 424), 
new Point(167, 432), 
new Point(170, 440), 
new Point(171, 451), 
new Point(200, 451), 
new Point(206, 444), 
new Point(209, 439), 
new Point(216, 432), 
new Point(225, 422), 
new Point(229, 403), 
new Point(233, 386), 
new Point(236, 367), 
new Point(240, 351), 
new Point(247, 334), 
new Point(248, 322), 
new Point(249, 308), 
new Point(256, 296), 
new Point(274, 283), 
new Point(317, 283), 
new Point(333, 285), 
new Point(348, 289), 
new Point(356, 292), 
new Point(362, 300), 
new Point(365, 314), 
new Point(369, 327), 
new Point(363, 340), 
new Point(347, 347), 
new Point(334, 357), 
new Point(319, 365), 
new Point(313, 377), 
new Point(311, 391), 
new Point(308, 403), 
new Point(329, 403), 
new Point(332, 418), 
new Point(336, 430), 
new Point(349, 437), 
new Point(382, 438), 
new Point(421, 438), 
new Point(450, 435), 
new Point(457, 428), 
new Point(461, 420), 
new Point(465, 413), 
new Point(472, 405), 
new Point(515, 405), 
new Point(521, 413), 
new Point(528, 420), 
new Point(537, 423), 
new Point(547, 427), 
new Point(556, 430), 
new Point(565, 428), 
new Point(575, 434), 
new Point(586, 433), 
new Point(600.5, 429) 

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