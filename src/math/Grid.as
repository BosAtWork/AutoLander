package  math
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Grid extends Sprite
	{
		public static var SPACING:Number = 10;
		
		
		public function Grid() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			graphics.lineStyle(1, 0xFFFFFF, 0.2);
			
			for (var x:int; x < stage.stageWidth; x += SPACING)
			{
				graphics.moveTo(x, 0);
				graphics.lineTo(x, stage.stageHeight);
				y = 0;
				for (var y:int; y < stage.stageWidth; y += SPACING)
				{
					var c:Dot = new Dot(x + ", " + y);
						c.x = x;
						c.y = y;
					addChild(c);
				}				
			}
			for (y = 0; y < stage.stageWidth; y += SPACING)
			{
				graphics.moveTo(0, y);
				graphics.lineTo(stage.stageWidth, y);
			}
		}		
	}
}