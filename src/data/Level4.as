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
	public class Level4 implements ILevel
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
		
		public function Level4() 
		{
			_lines = new Vector.<Line>();
			
			var i:int = 0;
			
			_data = Vector.<Point>([/*START_POINTS*/
			new Point(-0.5, 110), 
new Point(33, 107), 
new Point(53, 105), 
new Point(75, 109), 
new Point(93, 107), 
new Point(111, 110), 
new Point(134, 107), 
new Point(151, 104), 
new Point(167, 100), 
new Point(184, 103), 
new Point(198, 105), 
new Point(209, 102), 
new Point(223, 103), 
new Point(251, 104), 
new Point(300, 105), 
new Point(350, 107), 
new Point(384, 118), 
new Point(404, 161), 
new Point(386, 187), 
new Point(354, 188), 
new Point(320, 191), 
new Point(287, 195), 
new Point(247, 197), 
new Point(208, 195), 
new Point(169, 189), 
new Point(136, 191), 
new Point(108, 197), 
new Point(92, 205), 
new Point(83, 215), 
new Point(77, 229), 
new Point(75, 245), 
new Point(75, 260), 
new Point(81, 273), 
new Point(88, 281), 
new Point(97, 289), 
new Point(108, 293), 
new Point(120, 298), 
new Point(136, 303), 
new Point(160, 303), 
new Point(161, 316), 
new Point(163, 333), 
new Point(164, 346), 
new Point(168, 356), 
new Point(175, 369), 
new Point(187, 380), 
new Point(199, 394), 
new Point(214, 406), 
new Point(232, 415), 
new Point(246, 421), 
new Point(258, 425), 
new Point(273, 433), 
new Point(293, 434), 
new Point(312, 435), 
new Point(329, 434), 
new Point(344, 428), 
new Point(359, 422), 
new Point(378, 416), 
new Point(394, 409), 
new Point(407, 403), 
new Point(420, 397), 
new Point(458, 397), 
new Point(499, 373), 
new Point(521, 373), 
new Point(536, 355), 
new Point(538, 328), 
new Point(523, 303), 
new Point(497, 289), 
new Point(463, 280), 
new Point(425, 280), 
new Point(396, 292), 
new Point(366, 305), 
new Point(337, 309), 
new Point(310, 312), 
new Point(282, 319), 
new Point(262, 305), 
new Point(258, 285), 
new Point(262, 268), 
new Point(270, 259), 
new Point(279, 254), 
new Point(294, 248), 
new Point(306, 245), 
new Point(322, 241), 
new Point(343, 239), 
new Point(364, 237), 
new Point(388, 239), 
new Point(412, 243), 
new Point(438, 248), 
new Point(461, 252), 
new Point(481, 255), 
new Point(504, 265), 
new Point(528, 273), 
new Point(557, 279), 
new Point(600.5, 279) 

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