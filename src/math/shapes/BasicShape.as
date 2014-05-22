package math.shapes
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Automatic
	 */
	public class BasicShape
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		private var _rotation:Number = 0;
		
		//rotating x and y and back will result in rounding errors so the x will not be the same after rotating Math.PI and back. Thats why we save the original location
		//before the rotating in this variable. This will give the opportunity to 
		//1. Rotate by real values instead of applying extra rotating
		//2. use a setter instead of a function
		protected var _orignalPoint:Point;
		
		
		public function BasicShape()
		{
			_orignalPoint = new Point(x, y);
		}
		
		public function intersects(shape:BasicShape, ... rest):Vector.<Point>
		{
			var points:Vector.<Point> = null;
			
			if (shape is Circle)
			{
				points = intersectToCircle(shape as Circle);
			}
			else if (shape is Line)
			{
				points = intersectToLine(shape as Line);
			}
			
			return points;
		}
		
		/**
		 * Rotates the line 
		 * @param	rotation in radians
		 */		
		public function set rotation(rotation:Number):void
		{
			_rotation = rotation;
			//matrix: (We only need to rotate so we only need the skew and scale parameters abcd
				//a  b  u
				//c  d  v
				//tx ty w
			var a:Number = Math.cos(rotation); 	//x scale
			var b:Number = Math.sin(rotation); 	//y skew
			var c:Number = -b;					//x skew
			var d:Number = a;					//y scale
			
			//POINT*MATRIX -> (would be the same as we create a m = new Matrix() m.rotate(rotation) m.transformPoint(this.x, this.y)
			_x = (_orignalPoint.x * a) + _orignalPoint.y * c;
			_y = (_orignalPoint.x * b) + _orignalPoint.y * d;
		}
		
		public function debug(parent:Sprite, addLocation:Point = null, color:int = 0x00FF00):void
		{
			
		}
		
		protected function intersectToCircle(circle:Circle, ... rest):Vector.<Point>
		{
			return null;
		}
		
		protected function intersectToLine(line:Line, ... rest):Vector.<Point>
		{
			return null;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}
		
		public function get x():Number 
		{
			return _x;
		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function get rotation():Number 
		{
			return _rotation;
		}
		
		public function set orignalPoint(value:Point):void 
		{
			_orignalPoint = value;
		}
	}
}