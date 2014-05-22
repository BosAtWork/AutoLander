package land 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Dust extends Sprite 
	{
		
		public function Dust() 
		{
			graphics.beginFill(0xC0C0C0);
			graphics.drawCircle(0, 0, 10);
			graphics.endFill();
		}
		
	}

}