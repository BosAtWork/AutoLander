package math.shapes
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Intersection
	{
		/**
		 * Returns array of points
		 * null if no intersection is found
		 * @param	v1
		 * @param	c1
		 * @return object
		 */
		public static function lineToCircle(l1:Line, c1:Circle):Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>(2);
			
			var a:Number = sqr(l1.xLength) + sqr(l1.yLength);
			var b:Number = 2 * (l1.xLength * (l1.A.x - c1.x) + l1.yLength * (l1.A.y - c1.y));
			var cc:Number = sqr(c1.x) + sqr(c1.y) + sqr(l1.A.x) + sqr(l1.A.y) - 2 * (c1.x * l1.A.x + c1.y * l1.A.y) - sqr(c1.radius);
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
						points[0] = (Point.interpolate (l1.A, l1.B, 1 - u2));
					}
					if (0 <= u1 && u1 <= 1) 
					{
						points[1] = (Point.interpolate (l1.A, l1.B, 1 - u1));
					}
				}
			}
			
			return points;
		}
		
		/**
		 * Circle to circle intersection
		 * @param	v1
		 * @param	v2
		 * @return
		 */
		public static function circleToCircle(c1:Circle, c2:Circle):Vector.<Point>
		{
			var points:Vector.<Point> = new Vector.<Point>(2);
			var d:Number = Point.distance(new Point(c1.x, c1.y), new Point(c2.x, c2.y));
			
			if (d > c1.radius + c2.radius)
			{
				//circles are seperate
			}
			else if (d < c1.radius - c2.radius)
			{
				//one circle is contained in the other
			}
			else if(d == 0 && c1.radius == c2.radius)
			{
				//circles are the same infinite solutions
			}
			else
			{
				var a:Number = (sqr(c1.radius) - sqr(c2.radius) + sqr(d)) / (2 * d);
				var h:Number = Math.sqrt(sqr(c1.radius) - sqr(a));
				var p2:Point = new Point();
					p2.x = c1.x + a * (c2.x - c1.x) / d;
					p2.y = c1.y + a * (c2.y - c1.y) / d;
					
				var ip1:Point = new Point();
					ip1.x = p2.x + h * (c2.y - c1.y) / d;
					ip1.y = p2.y - h * (c2.x - c1.x) / d;
				var ip2:Point = new Point();
					ip2.x = p2.x - h * (c2.y - c1.y) / d;
					ip2.y = p2.y + h * (c2.x - c1.x) / d;
					
				points[0] = ip1;
				points[1] = ip2;
			}
			return points;
		}
		
		
		/**
		 * gets the intersection point of two vectors
		 * @param	v1
		 * @param	v2
		 */
		public static function lineToLine(l1:Line, l2:Line):Point
		{
			var ip:Point = new Point();
			
			var a1:Number 	=	l1.B.y	-	l1.A.y;
			var b1:Number	= 	l1.A.x	-	l1.B.x;
			var c1:Number	= 	l1.B.x	*	l1.A.y 	- 	l1.A.x	*	l1.B.y;
			var a2:Number	=	l2.B.y	-	l2.A.y;
			var b2:Number	= 	l2.A.x	-	l2.B.x;
			var c2:Number	= 	l2.B.x	*	l2.A.y 	- 	l2.A.x	*	l2.B.y;
		 
			var denom:Number = a1 * b2 - a2 * b1;
			
			if (denom == 0)	return null;
			
			ip.x = (b1*c2 - b2*c1)/denom;
			ip.y = (a2*c1 - a1*c2)/denom;
			
			if (ip.x < Math.min(l1.A.x, l1.B.x) || ip.x > Math.max(l1.A.x, l1.B.x)) 
			{
				return null;
			}
			if (ip.y < Math.min(l1.A.y, l1.B.y) || ip.y > Math.max(l1.A.y, l1.B.y)) 
			{
				return null;
			}
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
		/*
		public static function vectorToPolygon(l1:Line, p1:Polygon):Vector.<Point>
		{
			var lines:Vector.<Vector2D> = p1.lines;
			var ips:Vector.<Point> = new Vector.<Point>();
			for (var i:int; i < lines.length; i++)
			{
				var ip:Point = lineToLine(l1, lines[i]);
				if (ip != null)
				{
					ips.push(ip);
				}
			}
			return ips;
		}
		public static function polygonToPolygon(p1:Polygon, p2:Polygon):Vector.<Point>
		{
			var lines:Vector.<Vector2D> = p1.lines;
			var ips:Vector.<Point> = new Vector.<Point>();
			for (var i:int; i < lines.length; i++)
			{
				ips = ips.concat(vectorToPolygon(lines[i], p2));
			}
			return ips;
		}
		public static function circleToPolygon(c1:Circle, p1:Polygon):Vector.<Point>
		{
			var lines:Vector.<Vector2D> = p1.lines;
			var ips:Vector.<Point> = new Vector.<Point>();
			
			for (var i:int; i < lines.length; i++)
			{
				ips.concat(vectorToCircle(lines[i], c1));
			}
			
			return ips;
		}		
		*/
		private static function sqr(value:Number):Number{return value * value;}
	}
}