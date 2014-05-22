package data 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import math.shapes.Line;
	import math.Vector2D;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public interface ILevel 
	{
		function get data():Vector.<Point>;		
		function get lines():Vector.<Line>;
		
		function getLinesIn(x:Number, y:Number, radius:Number):Vector.<Line>;
		
		function get startLocation():Point;
		function get startVelocity():Vector2D;
		function get startRotation():Number;
		function get gravity():Number;
		
		function get timeScore():int;
		function get landScore():int;
	}	
}