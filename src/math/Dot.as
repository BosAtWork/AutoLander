package math
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Dot extends Sprite
	{
		private var myLabel:TextField = new TextField();
		
		public function Dot(text:String) 
		{
			graphics.beginFill(0xFFFFFF, 0);
			graphics.drawCircle(-2, -2, 4);
			graphics.endFill();
			
			myLabel.text = text;
			myLabel.background = true;
			myLabel.visible = false;
			myLabel.selectable = false;
			myLabel.autoSize = TextFieldAutoSize.LEFT;
			addChild(myLabel);
			
			addEventListener(MouseEvent.MOUSE_OVER, onOver);
			addEventListener(MouseEvent.MOUSE_OUT, onOut);
		}
		
		private function onOut(e:MouseEvent):void 
		{
			myLabel.visible = false;
		}
		
		private function onOver(e:MouseEvent):void 
		{
			myLabel.visible = true;
		}
		
	}

}