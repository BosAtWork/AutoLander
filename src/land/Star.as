package land 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Star extends Sprite 
	{
		private var movement:Number;
		
		public function Star() 
		{
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(0, 0, 1);
			graphics.endFill();
			
			movement =  (0.5 - Math.random()) / 4;
		}	
		
		public function update():void
		{
			this.x += movement;
			
			if (this.x < -605)
			{
				this.x = 1205;
			}
			else if (this.x > 1205)
			{
				this.x = -605;
			}
		}
	}
}