package math.shapes
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Point;
	import math.Vector2D;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Circle extends BasicShape
	{
		private var _radius:Number;
		
		public function Circle(radius:Number, x:Number = 0, y:Number = 0) 
		{
			this._radius = radius;
			
			this.x = x;
			this.y = y;
			
			super();
		}
		
		override public function debug(parent:Sprite, addLocation:Point = null, color:int = 0x00FF00):void
		{
			parent.graphics.lineStyle(1, color, 0.2);
			if (addLocation)
			{
				parent.graphics.drawCircle(x + addLocation.x, y + addLocation.y, radius);
			}
			else
			{
				parent.graphics.drawCircle(x, y, radius);
			}			
		}
		
		public function centerToPoint(ip:Point):Vector2D
		{
			if (ip == null) { return null; }
			
			var temp:Point = ip.subtract(new Point(x, y));
				temp.normalize(1);			
			return new Vector2D(temp.x, temp.y);
		}
		
		public function bounceDirection(l1:Line):Vector2D
		{
			var ip:Point = Intersection.lineToCircle(l1, this)[0];
			
			if (ip == null){return null;}
			
			var diagonal:Line = new Line(new Point(l1.x, l1.y).subtract(new Point(x,y)));
				diagonal.x = x;
				diagonal.y = y;
				
			return l1.vector.reflection(diagonal.vector.lNormal);
		}
		
		/**
		 * Check if this line intersect with given line
		 * @param	l2
		 * @param	checkLine1 if intersection point needs to be in the line 1
		 * @param	checkLine2 if intersection point needs to be in the line 2
		 * @return
		 */
		override protected function intersectToLine(l1:Line, ... rest):Vector.<Point>
		{
			//var result:Object = lineIntersectCircle(l1.A, l1.B, new Point(x, y), radius);
			
			var points:Vector.<Point> = new Vector.<Point>(2);
			
			var A:Point = l1.A;
			var B:Point = l1.B;
			
			var dirLine:Vector2D = l1.vector.copy.scale(l1.length); //Direction from A to B of the line (non-normalized)
			var dirLineCircle:Vector2D = new Vector2D(A.x - x, A.y - y); //Direction from end of array to center of circle
			
			var a:Number = dirLine.dot(dirLine);
			var b:Number = 2 * dirLineCircle.dot(dirLine);			
			var c:Number = dirLineCircle.dot(dirLineCircle) - radius * radius;
			
			var discriminant:Number = b * b - 4 * a * c;
			
			if (discriminant <= 0 ) 
			{
				return points;
			} 
			else 
			{
				var e : Number = Math.sqrt (discriminant);
				var u1 : Number = ( - b + e ) / (2 * a );
				var u2 : Number = ( - b - e ) / (2 * a );
				if ((u1 < 0 || u1 > 1) && (u2 < 0 || u2 > 1)) {
					if ((u1 < 0 && u2 < 0) || (u1 > 1 && u2 > 1)) {
						return points;
					} else {
						return points;
					}
				} else {
					if (0 <= u2 && u2 <= 1) {
						points[0] =Point.interpolate (A, B, 1 - u2);
					}
					if (0 <= u1 && u1 <= 1) {
						points[1]=Point.interpolate (A, B, 1 - u1);
					}
				}
			}
			return points;
		}
		
		/**
		 * Same formula as above except it gives true or false and removes some checks for points
		 * @param	l1
		 * @return
		 */
		public function containsOrIntersectsLine(l1:Line):Boolean
		{
			var points:Vector.<Point> = new Vector.<Point>(2);
			
			var A:Point = l1.A;
			var B:Point = l1.B;
			
			var dirLine:Vector2D = l1.vector.copy.scale(l1.length); //Direction from A to B of the line (non-normalized)
			var dirLineCircle:Vector2D = new Vector2D(A.x - x, A.y - y); //Direction from end of array to center of circle
			
			var a:Number = dirLine.dot(dirLine);
			var b:Number = 2 * dirLineCircle.dot(dirLine);			
			var c:Number = dirLineCircle.dot(dirLineCircle) - radius * radius;
			
			var discriminant:Number = b * b - 4 * a * c;
			
			if (discriminant <= 0 ) 
			{
				return false;
			} 
			else 
			{
				var e : Number = Math.sqrt (discriminant);
				var u1 : Number = ( - b + e ) / (2 * a );
				var u2 : Number = ( - b - e ) / (2 * a );
				if ((u1 < 0 || u1 > 1) && (u2 < 0 || u2 > 1)) {
					if ((u1 < 0 && u2 < 0) || (u1 > 1 && u2 > 1)) {
						return false;
					} else {
						return true;
					}
				} 
				else 
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * checks if this line intersects with given circle
		 * @param	c1
		 * @return
		 */
		override protected function intersectToCircle(c2:Circle, ... rest):Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>(2);
			var d:Number = Point.distance(new Point(this.x, this.y), new Point(c2.x, c2.y));
			var sqr:Function = Math.sqrt;
			
			if (d > this.radius + c2.radius)
			{
				//circles are seperate
			}
			else if (d < this.radius - c2.radius)
			{
				//one circle is contained in the other
			}
			else if(d == 0 && this.radius == c2.radius)
			{
				//circles are the same infinite solutions
			}
			else
			{
				var a:Number = (sqr(this.radius) - sqr(c2.radius) + sqr(d)) / (2 * d);
				var h:Number = Math.sqrt(sqr(this.radius) - sqr(a));
				var p2:Point = new Point();
					p2.x = this.x + a * (c2.x - this.x) / d;
					p2.y = this.y + a * (c2.y - this.y) / d;
					
				var ip1:Point = new Point();
					ip1.x = p2.x + h * (c2.y - this.y) / d;
					ip1.y = p2.y - h * (c2.x - this.x) / d;
				var ip2:Point = new Point();
					ip2.x = p2.x - h * (c2.y - this.y) / d;
					ip2.y = p2.y + h * (c2.x - this.x) / d;
					
				points[0] = ip1;
				points[1] = ip2;
			}
			return points;
		}
		
		public function toString():String
		{
			return "Circle x: " + x  + ", y: " + y + ", r: " + radius;
		}	
		
		public function get radius():Number { return _radius; }
	}
}