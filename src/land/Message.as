package land 
{
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Message extends TextField 
	{		
		private var smallFormat:TextFormat;
		private var bigFormat:TextFormat;
		
		public function Message(fontSize:Number) 
		{
			smallFormat = new TextFormat("VectorBattle", fontSize/2, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
			smallFormat.letterSpacing = 2;
			smallFormat.leading = 2;
				
			bigFormat = new TextFormat("VectorBattle", fontSize, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
			bigFormat.letterSpacing = 2;
			bigFormat.leading = 2;
			
			selectable = false;
			antiAliasType = AntiAliasType.ADVANCED;
			embedFonts = true;
			sharpness = -400;
			defaultTextFormat = smallFormat;
		}
		
		public function changeText(value:String, extra:String = ""):void
		{
			this.text = value + "\n\n" + extra;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.setTextFormat(bigFormat, 0, value.length);
		}
		
		public function center():void
		{
			visible = true;			
			this.x = -(this.width / 2) + 300;
			this.y = 170;
		}
	}
}