package math
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import math.shapes.Line;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Vector2D
	{
		private var _x:Number;
		private var _y:Number;
		
		public function Vector2D(x:Number, y:Number) 
		{
			_x = x;
			_y = y;
		}		
		
		/**
		 * Calculets the dot product of this vector equals to v2
		 * @param	v2
		 * @return
		 */
		public function dot(v2:Vector2D):Number	
		{		
			return (x * v2.x) + (y * v2.y);			
		}
		
		/**
		 * scales vector by value
		 * @param	value
		 * @return this vector
		 */
		public function scale(value:Number):Vector2D
		{
			this._x *= value;
			this._y *= value;
			return this;
		}
		
		/**
		 * Calculets the per product of this vector equals to v2
		 * @param	v2
		 * @return
		 */
		public function per(v2:Vector2D):Number	
		{		
			return 0;								
		}
		
		/**
		 * Calculets the cross product of this vector equals to v2
		 * @param	v2
		 * @return
		 */
		public function cross(v2:Vector2D):Number 
		{	
			return Math.abs((x * v2.y) - (y * v2.x));	
		}
		
		/**
		 * Calculets the angle of this vector to v2
		 * @param	v2
		 * @return
		 */
		/*public function angle(v2:Vector2D):Number
		{
			return Math.acos(dot(v2) / (magnitude * v2.magnitude)) * (180 / Math.PI);
		}*/
		
		/**
		 * Calculets the projection1 of this vector equals to v2
		 * @param	v2
		 * @return
		 */
		public function lProjection(v2:Vector2D):Vector2D
		{
			return new Vector2D(dot(v2) * v2.x, dot(v2) * v2.y);	
		}	
		
		/**
		 * Calculets the projection2 of this vector equals to v2
		 * @param	v2
		 * @return
		 */
		public function rProjection(v2:Vector2D):Vector2D
		{
			return new Vector2D( -1 * (dot(v2.lNormal) * v2.lNormal.x), -1 * (dot(v2.lNormal) * v2.lNormal.y));
		}		
		
		public function reflection(v2:Vector2D):Vector2D
		{
			return new Vector2D(lProjection(v2).x + rProjection(v2).x, lProjection(v2).y + rProjection(v2).y);
		}
		
		/**
		 * get the length of this vector
		 * @return
		 */
		public function get length():Number
		{
			return Point.distance(new Point(), new Point(x, y));
		}
		
		/**
		 * set the length of this vector
		 * @return
		 */
		public function set length(value:Number):void
		{
			var normalized:Vector2D = normalize;
			this._x = normalized.x * value;
			this._y = normalized.y * value;
		}
		
		/**
		 * normalize this vector
		 * @return this vector
		 */
		public function get normalize():Vector2D
		{
			var d:Number = Point.distance(new Point(), new Point(x,y));			
			return new Vector2D(this.x / d, this.y /d);
		}
		
		/**
		 * Converts the vector to a string
		 * @return
		 */
		public function toString():String
		{
			return "Vector2D{x:" + x + ", y:" + y + "}";
		}
		
		/**
		 * adds vector to this one
		 * @param	v2
		 */
		public function add(v2:Vector2D):void
		{
			x += v2.x;
			y += v2.y;
		}
		
		public function get x():Number 				{ return _x; 								}		
		public function get y():Number 				{ return _y; 								}
		public function get copy():Vector2D			{ return new Vector2D(x, y);				}
		public function get lNormal():Vector2D		{ return new Vector2D(y, -x);				}
		public function get rNormal():Vector2D		{ return new Vector2D( -y, x);				}
		public function get invert():Vector2D		{ return new Vector2D( -1 * x, -1 * y);		}
		
		public function set x(value:Number):void 
		{
			_x = value;
		}
		
		public function set y(value:Number):void 
		{
			_y = value;
		}		
		public function set rotation(radians:Number):void
		{
			_x = Math.cos(radians);
			_y = Math.sin(radians);
		}
		public function get rotation():Number
		{
			return Math.atan2(y, x);
		}
		private function degToRad(degrees:Number):Number
		{
			return degrees * 0.0174532925;
		}
		private function radToDeg(radians:Number):Number
		{
			return radians * 57.2957795;
		}
		
		/**
		 * Convert a single point to a vector based from 0,0
		 * @param	b
		 */
		public static function vectorFromPoint(b:Point):Vector2D
		{			
			var d:Number = Point.distance(new Point(), b);
			
			return new Vector2D(b.x/d, b.y/d);
		}
		
		/**
		 * Check if this line intersect with given line
		 * @param	l1
		 * @param	l2
		 * @return
		 */
		public function intersectToLine(l2:Line, begin:Point):Point
		{
			var ip:Point = new Point();
			
			var a1:Number 	=	(begin.y+y)		-	begin.y;
			var b1:Number	= 	begin.x			-	(begin.x + x);
			var c1:Number	= 	(begin.x + x)	*	begin.y 		- 	begin.x		*	(begin.y+y);
			var a2:Number	=	l2.B.y			-	l2.A.y;
			var b2:Number	= 	l2.A.x			-	l2.B.x;
			var c2:Number	= 	l2.B.x			*	l2.A.y 			- 	l2.A.x		*	l2.B.y;
		 
			var denom:Number = a1 * b2 - a2 * b1;
			
			if (denom == 0)	return null;
			
			ip.x = (b1*c2 - b2*c1)/denom;
			ip.y = (a2*c1 - a1*c2)/denom;
			
			if (ip.x < Math.min(l2.A.x, l2.B.x) || ip.x > Math.max(l2.A.x, l2.B.x)) 
			{
				return null;
			}
			if (ip.y < Math.min(l2.A.y, l2.B.y) || ip.y > Math.max(l2.A.y, l2.B.y)) 
			{
				return null;
			}
			
			a1 = 0, b1 = 0, c1 = 0;
			a2 = 0, b2 = 0, c2 = 0;
			
			return ip;
		}
		
		public function toPoint():Point 
		{
			return new Point(x, y);
		}
	}
}