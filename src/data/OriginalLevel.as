package data 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	import land.Game;
	import math.shapes.Circle;
	import math.shapes.Line;
	import math.Vector2D;
	/**
	 * ...
	 * @author Automatic
	 */
	public class OriginalLevel implements ILevel
	{
		private var _data:Vector.<Point>;
		private var _lines:Vector.<Line>;
		
		private var _gravity:Number = 0.0005;
		private var _startRotation:Number = 90;
		private var _startVelocity:Vector2D = new Vector2D(0.2, 0.1);
		private var _startLocation:Point = new Point(110, 110);
		private var _timeScore:Number = 1000;
		private var _landScore:Number = 500;
		
		public function OriginalLevel() 
		{
			_lines = new Vector.<Line>();
			
			_data = Vector.<Point>([/*START_POINTS*/
				new Point(0.5, 355.55),
            new Point(5.45, 355.55),
            new Point(6.45, 359.4),
            new Point(11.15, 359.4),
            new Point(12.1, 363.65),
            new Point(14.6, 363.65),
            new Point(15.95, 375.75),
            new Point(19.25, 388),
            new Point(19.25, 391.9),
            new Point(21.65, 400),
            new Point(28.85, 404.25),
            new Point(30.7, 412.4),
            new Point(33.05, 416.7),
            new Point(37.9, 420.5),
            new Point(42.7, 420.5),
            new Point(47.4, 416.65),
            new Point(51.75, 409.5),
            new Point(56.55, 404.25),
            new Point(61.3, 400),
            new Point(63.65, 396.15),
            new Point(68, 391.9),
            new Point(70.3, 388),
            new Point(75.1, 386.1),
            new Point(79.85, 379.95),
            new Point(84.7, 378.95),
            new Point(89.05, 375.65),
            new Point(93.75, 375.65),
            new Point(98.5, 376.55),
            new Point(103.2, 379.95),
            new Point(104.3, 383.8),
            new Point(107.55, 388),
            new Point(108.95, 391.9),
            new Point(112.4, 396.15),
            new Point(113.3, 400),
            new Point(117.1, 404.25),
            new Point(121.95, 404.25),
            new Point(125.3, 396.3),
            new Point(128.6, 394.2),
            new Point(132.45, 396.15),
            new Point(135.75, 399.9),
            new Point(138.15, 408.15),
            new Point(144.7, 412.4),
            new Point(146.3, 424.8),
            new Point(149.55, 436.65),
            new Point(149.55, 441.05),
            new Point(154.35, 444.85),
            new Point(163.45, 444.85),
            new Point(168.15, 441.05),
            new Point(172.95, 436.75),
            new Point(175.45, 432.9),
            new Point(179.7, 428.6),
            new Point(181.95, 424.8),
            new Point(186.7, 422.5),
            new Point(189.15, 412.4),
            new Point(191.55, 404.35),
            new Point(196.35, 402.4),
            new Point(200.7, 398.1),
            new Point(205.45, 391.9),
            new Point(210.15, 383.8),
            new Point(212.55, 375.75),
            new Point(216.85, 371.8),
            new Point(219.3, 367.55),
            new Point(220.65, 363.65),
            new Point(224, 359.4),
            new Point(228.8, 359.4),
            new Point(233.55, 355.55),
            new Point(237.85, 348.45),
            new Point(242.65, 343.2),
            new Point(245, 335.15),
            new Point(247.35, 322.8),
            new Point(247.3, 314.5),
            new Point(248.35, 306.55),
            new Point(252.2, 296.5),
            new Point(256.55, 294.55),
            new Point(257.95, 290.4),
            new Point(261.25, 285.95),
            new Point(265.95, 285.95),
            new Point(267, 290.25),
            new Point(271.75, 290.25),
            new Point(273.25, 294.55),
            new Point(275.2, 294.55),
            new Point(278.95, 296.5),
            new Point(282.25, 300.3),
            new Point(284.7, 308.45),
            new Point(291.85, 312.65),
            new Point(298.55, 330.8),
            new Point(303.25, 331.8),
            new Point(308, 335.05),
            new Point(309, 338.9),
            new Point(312.35, 343.2),
            new Point(313.8, 347.05),
            new Point(317.05, 351.4),
            new Point(321.9, 351.4),
            new Point(322.85, 363.8),
            new Point(326.6, 375.75),
            new Point(326.6, 379.95),
            new Point(330.9, 379.95),
            new Point(332.4, 383.8),
            new Point(335.8, 388),
            new Point(338.1, 396.15),
            new Point(340.45, 400.1),
            new Point(345.3, 404.25),
            new Point(346.25, 416.65),
            new Point(349.6, 428.7),
            new Point(349.6, 432.85),
            new Point(350.95, 436.75),
            new Point(354.3, 441.05),
            new Point(359, 441.05),
            new Point(361.4, 449.1),
            new Point(363.95, 453),
            new Point(368.2, 457.2),
            new Point(372.9, 461),
            new Point(410.2, 461),
            new Point(412.55, 449.1),
            new Point(417.4, 441.05),
            new Point(419.7, 432.9),
            new Point(422.05, 432.9),
            new Point(425.45, 424.8),
            new Point(428.8, 422.35),
            new Point(433.45, 416.65),
            new Point(438.25, 415.15),
            new Point(442.6, 412.4),
            new Point(447.4, 412.4),
            new Point(448.8, 416.65),
            new Point(454.55, 430.55),
            new Point(455.5, 434.8),
            new Point(459.25, 438.6),
            new Point(462.6, 440.9),
            new Point(466, 444.85),
            new Point(468.35, 452.9),
            new Point(475.55, 457.3),
            new Point(484.7, 457.3),
            new Point(494.7, 458.2),
            new Point(503.75, 461.1),
            new Point(522.2, 461.1),
            new Point(524.75, 453),
            new Point(527.1, 441.05),
            new Point(527.1, 432.9),
            new Point(531.9, 432.9),
            new Point(534.15, 424.8),
            new Point(538.6, 420.5),
            new Point(540.9, 416.65),
            new Point(542.35, 412.5),
            new Point(545.7, 408),
            new Point(550.45, 408),
            new Point(552.85, 398.1),
            new Point(554.75, 389.95),
            new Point(559.55, 388),
            new Point(564.35, 391.9),
            new Point(573.35, 391.9),
            new Point(578.1, 388),
            new Point(579.55, 379.95),
            new Point(582.9, 369.4),
            new Point(587.75, 367.55),
            new Point(588.65, 363.8),
            new Point(592.05, 359.5),
            new Point(596.85, 355.55),
			new Point(598.05, 359.5),
			new Point(600.65, 363.8),
			new Point(603.75, 367.55)
			/*END_POINTS*/]);
			
			var i:int = 0;
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