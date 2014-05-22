package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import land.Game;
	import player.HUD;
	
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Main extends Sprite 
	{
		public static var DEBUG:Sprite;	
		
		private var _game:Game;
		private var _hud:HUD;
		
		public function Main():void
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//Entry for debugging sprites
			DEBUG = this;
			
			//create hud in the Main class (Game tends to move and we don't want hud to move with the game)
			_hud = new HUD();
			
			//create the game and pass it the hud we created
			_game = new Game(_hud);			
			addChild(_game);
			
			//add the hud over the game (as a overlay)
			addChild(_hud);
		}
	}	
}