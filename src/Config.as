package  
{
	import data.ILevel;
	import data.Level1;
	import data.Level2;
	import data.Level3;
	import data.Level4;
	import data.OriginalLevel;
	import data.TestLevel;
	import land.GameState;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Config 
	{
		public static const LEVELS:Vector.<ILevel> = Vector.<ILevel>([new Level1, new Level2(), new Level3(), new OriginalLevel()]);
		
		public static const DEBUG:Boolean = false;
		
		//ship variables
		public static const START_FUEL:int = 1000;
		public static const THRUST_CONSTANT:Number = 0.0015;
        public static const DRAG:Number = 0.999;
		public static const TOP_SPEED:Number = 5; 				//0.35
		public static const BURST_LENGTH:int = 3000;
		
		//constant variables
		public static const START_LEVEL:int = 0;		
		public static const START_SCORE:int = 0;
		
		//TEXT
		public static const START_MESSAGE:String = "PRESS A KEY TO PLAY";
		public static const EXTRA_START_MESSAGE:String = "ARROW KEYS TO MOVE\nSPACE FOR ONE TIME BOOSTER";
		public static const NEXT_LEVEL:String = "PRESS A KEY TO ADVANCE TO THE NEXT LEVEL"
		
		public static const RESTART:String = "PRESS A KEY TO TRY AGAIN";
		public static const OUT_OF_BOUNDS:String = "ENGINE FAILED FOR UNKNOWN REASON!?";
		public static const NO_GRAVITY:String = "FLYING ENDLESS IN SPACE"
		
		private static var landText:Array = ["Perfect landing", "You landed your ship perfectly", "Thats the way"];
		
		static public function get LANDED_TEXT():String
		{
			return landText[Math.floor(Math.random() * landText.length)];
		}
		
		static public function CRASH_TEXT(state:String):String 
		{
			if (state == GameState.CRASHED_NOT_FLAT)
			{
				return "DO YOU THINK IT IS A CROSS MOTOR?";
			}
			else if (state == GameState.CRASHED_ROTATED)
			{
				return "LUNAR MODULE'S CAN'T LAND ON ONE FEET!";
			}
			else if (state == GameState.CRASHED_TOO_FAST)
			{
				return "YOU JUST RUINED A SPACESHIP SPEED MANIAC!";
			}
			return "YOU JUST CRASHED";
		}
	}
}