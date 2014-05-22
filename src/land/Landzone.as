package land 
{
	import flash.text.TextField;
	import math.shapes.Line;
	/**
	 * ...
	 * @author Automatic
	 */
	public class Landzone 
	{
		private var _line:Line;
		private var _label:Label;
		private var _multiplier:int;
		
		public function Landzone(line:Line, multiplier:int) 
		{
			_multiplier = multiplier;
			_line = line;
			
			_label = new Label(multiplier);
			_label.x = _line.x + 2;
			_label.y = _line.y + 2;
		}
		
		public function get label():Label 
		{
			return _label;
		}
		
		public function get line():Line 
		{
			return _line;
		}
		
		public function get multiplier():int 
		{
			return _multiplier;
		}
	}
}