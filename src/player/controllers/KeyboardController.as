package player.controllers 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import player.IController;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class KeyboardController extends EventDispatcher implements IController 
	{
		private var _left:Boolean = false;
		private var _up:Boolean = false;
		private var _down:Boolean = false;
		private var _right:Boolean = false;
		
		public function KeyboardController(stage:Stage) 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
		}
		
		private function onDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.RIGHT || Keyboard.SPACE)
			{
				dispatchEvent(e.clone());
			}			
		}
	}
}