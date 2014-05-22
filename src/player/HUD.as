package player 
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class HUD extends Sprite 
	{
		//left view for data
		private var _leftView:TextField = new TextField();
		
		//right view for data
		private var _rightView:TextField = new TextField();
		
		public function HUD() 
		{
			//formatting and adding the textfields
			var format:TextFormat = new TextFormat("VectorBattle", 10, 0xFFFFFF);
				format.letterSpacing = 2;
				format.leading = 2;
				
			_leftView.selectable = false;
			_leftView.x = _leftView.y = 30;
			_leftView.antiAliasType = AntiAliasType.ADVANCED;
			_leftView.embedFonts = true;
			_leftView.sharpness = -400;
			_leftView.width = 200;
			_leftView.defaultTextFormat = format;
			
			addChild(_leftView);
			
			_rightView.selectable = false;
			_rightView.x = 360;
			_rightView.y = 30;
			_rightView.antiAliasType = AntiAliasType.ADVANCED;
			_rightView.embedFonts = true;
			_rightView.sharpness = -400;
			_rightView.width = 220;
			_rightView.defaultTextFormat = format;
			
			addChild(_rightView);
		}
		
		//for resetting the hud after crashed
		public function reset():void
		{
			_leftView.text = "";
			_rightView.text = "" ;
		}
		
		/**
		 * Update the hud with the given parameters (not the best way to code it but it works)
		 * @param	score
		 * @param	time
		 * @param	fuel
		 * @param	altitude
		 * @param	xSpeed
		 * @param	ySpeed
		 * @param	higestScore
		 */
		public function update(score:Number, time:Number, fuel:Number, altitude:Number, xSpeed:Number, ySpeed:Number, higestScore:Number):void
		{
			//calculate the time in seconds and minutes based from milliseconds
			var seconds:int = Math.floor(time / 600);
			var minutes:int = Math.floor(seconds / 60);
				seconds -= minutes * 60;
			
			var secondsString:String = seconds.toString();
			if (secondsString.length == 1)
			{
				secondsString = "0" + secondsString;
			}
			
			_leftView.text = "SCORE\t\t" + score;
			_leftView.appendText("\nHIGHSCORE\t" + higestScore);
			_leftView.appendText("\nTIME\t\t\t" + minutes + ":" + secondsString);
			_leftView.appendText("\nFUEL\t\t\t" + fuel);
			
			_rightView.text = "ALTITUDE\t\t\t\t\t" + Math.round(altitude);
			_rightView.appendText("\nHORIZONTAL SPEED\t\t" + Math.round(xSpeed*100));
			_rightView.appendText("\nVERTICAL SPEED\t\t" + Math.round(ySpeed*100));
		}
	}
}