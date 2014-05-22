package math.shapes
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import math.Vector2D;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Line extends BasicShape
	{
		private var _vector:Vector2D;		
		private var _length:Number;
		
		
		/**
		 * 
		 * @param	from
		 * @param	to
		 */
		public function Line(to:Point, from:Point = null) 
		{			
			if (from != null)
			{
				this.x = from.x; 
				this.y = from.y;
				_vector = Vector2D.vectorFromPoint(to.subtract(from));
				_length = Point.distance(from, to);
			}
			else
			{
				_vector = Vector2D.vectorFromPoint(to);
				_length = Point.distance(new Point(), to);
			}			
			
			super();
		}
		
		override public function set rotation(value:Number):void
		{
			_vector.rotation += value - rotation;
			
			super.rotation = value;
		}
		
		public function bounceDirection(l1:Line):Vector2D
		{
			return vector.reflection(l1.vector);
		}		
		
		public function get vector():Vector2D 			{ 	return _vector; 					}
		public function get xLength():Number			{	return vector.x * length;			}
		public function get yLength():Number			{	return vector.y * length;			}			
		public function get length():Number 			{	return _length; 					}		
		public function set length(value:Number):void 	{	_length = value; 					}
		
		public function get A():Point					
		{	
			return new Point(x, y);				
		}
		public function get B():Point					
		{	
			return new Point(x + vector.x * length, y + vector.y * length);
		}
		
		public function toString():String
		{
			return "Line A: " + A + ", B: " + B;
		}		
		
		override public function debug(parent:Sprite, addPosition:Point = null, color:int = 0x00FF00):void
		{
			parent.graphics.lineStyle(1, color, 0.2);
			if (addPosition == null)
			{
				parent.graphics.moveTo(x, y);
				parent.graphics.lineTo(B.x, B.y);
			}	
			else
			{
				parent.graphics.moveTo(addPosition.x + x, addPosition.y + y);
				parent.graphics.lineTo(addPosition.x + B.x, addPosition.y + B.y);
			}
		}
		
		/**
		 * Check if this line intersect with given line
		 * @param	l2
		 * @param	checkLine1 if intersection point needs to be in the line 1
		 * @param	checkLine2 if intersection point needs to be in the line 2
		 * @return
		 */
		override protected function intersectToLine(l2:Line, ... rest):Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>(1);
			
			var checkLine1:Boolean = true || rest[0];
			var checkLine2:Boolean = true || rest[1];
			
			//this method is 17 ms faster than doing the compare if statement myself //if (this.x < l2.B.x && this.B.x > l2.x && this.y < l2.B.y && this.B.y > l2.y)
			//it is also faster 5 ms faster than creating a tempRect outside this function in the class member as cach
			var tempRect:Rectangle = new Rectangle(this.x, this.y, this.vector.x * this.length, this.vector.y * this.length);
			var tempRect2:Rectangle = new Rectangle(l2.x, l2.y, l2.vector.x * l2.length, l2.vector.y * l2.length);
			
			if (this.x < l2.B.x && this.B.x > l2.x && this.y < l2.B.y && this.B.y > l2.y){
				return points;
			}
			
			var ip:Point = new Point();
			
			var a1:Number 	=	this.B.y	-	this.A.y;
			var b1:Number	= 	this.A.x	-	this.B.x;
			var c1:Number	= 	this.B.x	*	this.A.y 	- 	this.A.x	*	this.B.y;
			var a2:Number	=	l2.B.y		-	l2.A.y;
			var b2:Number	= 	l2.A.x		-	l2.B.x;
			var c2:Number	= 	l2.B.x		*	l2.A.y 		- 	l2.A.x		*	l2.B.y;
		 
			var denom:Number = a1 * b2 - a2 * b1;
			
			if (denom == 0)	return points;
			
			ip.x = (b1*c2 - b2*c1)/denom;
			ip.y = (a2*c1 - a1*c2)/denom;
			if (checkLine1)
			{			
				if (ip.x < Math.min(this.A.x, this.B.x) || ip.x > Math.max(this.A.x, this.B.x)) 
				{
					return points;
				}
				if (ip.y < Math.min(this.A.y, this.B.y) || ip.y > Math.max(this.A.y, this.B.y)) 
				{
					return points;
				}
			}
			if (checkLine2)
			{
				if (ip.x < Math.min(l2.A.x, l2.B.x) || ip.x > Math.max(l2.A.x, l2.B.x)) 
				{
					return points;
				}
				if (ip.y < Math.min(l2.A.y, l2.B.y) || ip.y > Math.max(l2.A.y, l2.B.y)) 
				{
					return points;
				}
			}
			a1 = 0, b1 = 0, c1 = 0;
			a2 = 0, b2 = 0, c2 = 0;
			
			points[0] = ip;
			
			return points;
		}
		
		/**
		 * checks if this line intersects with given circle
		 * @param	c1
		 * @return
		 */
		override protected function intersectToCircle(c1:Circle, ... rest):Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>(2);
			
			var a:Number = sqr(this.xLength) + sqr(this.yLength);
			var b:Number = 2 * (this.xLength * (this.A.x - c1.x) + this.yLength * (this.A.y - c1.y));
			var cc:Number = sqr(c1.x) + sqr(c1.y) + sqr(this.A.x) + sqr(this.A.y) - 2 * (c1.x * this.A.x + c1.y * this.A.y) - sqr(c1.radius);
			var deter : Number = sqr(b) - 4 * a * cc;
			
			if (deter <= 0 ) 
			{
				//trace("no intersection");
			} 
			else 
			{
				var e:Number = Math.sqrt(deter);
				var u1:Number = (-b + e ) / (2 * a);
				var u2:Number = (-b - e ) / (2 * a);
				if ((u1 < 0 || u1 > 1) && (u2 < 0 || u2 > 1)) 
				{
					if ((u1 < 0 && u2 < 0) || (u1 > 1 && u2 > 1)) 
					{
						//trace("line isn't inside the circle");
					} 
					else 
					{
						//trace("line is inside circle");
					}
				} 
				else 
				{
					if (0 <= u2 && u2 <= 1) 
					{
						points[0] = (Point.interpolate (this.A, this.B, 1 - u2));
					}
					if (0 <= u1 && u1 <= 1) 
					{
						points[1] = (Point.interpolate (this.A, this.B, 1 - u1));
					}
				}
			}
			
			return points;
		}
		
		private function sqr(value:Number):Number{return value * value;}
	}
}