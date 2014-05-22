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
	public class Label extends TextField 
	{
		private var smallFormat:TextFormat;
		private var bigFormat:TextFormat;
		
		public function Label(multiplier:int) 
		{
			smallFormat = new TextFormat("VectorBattle", 4, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
			smallFormat.letterSpacing = 2;
			smallFormat.leading = 2;
				
			bigFormat = new TextFormat("VectorBattle", 7, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
			bigFormat.letterSpacing = 2;
			bigFormat.leading = 2;
			
			selectable = false;
			antiAliasType = AntiAliasType.ADVANCED;
			embedFonts = true;
			sharpness = -400;
			defaultTextFormat = smallFormat;
			
			this.text = "x" + multiplier;
			
			this.setTextFormat(bigFormat, 1, this.text.length);
			
			this.autoSize = TextFieldAutoSize.LEFT;
			
		}		
	}
}