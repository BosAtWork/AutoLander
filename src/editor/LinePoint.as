package editor 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class LinePoint extends Sprite 
	{		
		private var text:TextField = new TextField();
		
		public function LinePoint() 
		{
			text.selectable = false;
			
			unSelect();
		}
		
		public function select():void 
		{
			graphics.clear();
			graphics.lineStyle(1, 0xFF0000);
			graphics.beginFill(0xFF8000);			
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
		
		public function unSelect():void 
		{
			graphics.clear();
			
			graphics.beginFill(0xFF8000);			
			graphics.drawCircle(0, 0, 5);
			graphics.endFill();
		}
	}
}