package editor 
{
	import adobe.utils.ProductManager;
	import com.bit101.components.Panel;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import land.Landscape;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class Main extends Sprite 
	{
		private var _points:Vector.<LinePoint> = new Vector.<LinePoint>();
		
		private var _landScape:Landscape;
		
		private var _dragging:LinePoint;
		
		private var _selected:LinePoint;
		
		private var _panel:EditPanel;
		
		private var _pointSprite:Sprite = new Sprite();
		
		public function Main() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			
			graphics.beginFill(0x80FF00, 0.1);
			graphics.drawRect(0, 0, 800, 480);
			graphics.drawRect(100, 0, 600, 480);
			graphics.endFill();
			
			_panel = new EditPanel(this);
			addChild(_pointSprite);
			addChild(_panel);
			_panel.x = 800;
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.DELETE)
			{
				if (_selected)
				{
					_selected.unSelect();
					_pointSprite.removeChild(_selected);
					
					for (var i:int; i < _points.length; i++)
					{
						if (_points[i] == _selected)
						{
							break;
						}
					}
					_selected = null
					_points.splice(i, 1);
					drawLevel();
				}
			}
		}
		
		private function onFrame(e:Event):void 
		{
			if (_dragging)
			{
				_dragging.x = stage.mouseX;
				_dragging.y = stage.mouseY;
				if (_dragging.x < 99.5)
				{
					_dragging.x = 99.5;
				}
				else if (_dragging.x > 700.5)
				{
					_dragging.x = 700.5;
				}
				drawLevel();
			}
		}
		
		private function onUp(e:MouseEvent):void 
		{
			_dragging = null;
		}
		
		private function fRemoveDup(ac:Vector.<LinePoint>) : void
		{
			var i:int, j : int;
			for (i = 0; i < ac.length - 1; i++)
				for (j = i + 1; j < ac.length; j++)
					if (ac[i].x == ac[j].x && ac[i].y == ac[j].y)
						ac.splice(j, 1);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var point:LinePoint = new LinePoint();
				point.x = e.stageX;
				point.y = e.stageY;
				point.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
				point.addEventListener(MouseEvent.CLICK, onPreventClick);
			_pointSprite.addChild(point);
			
			if (point.x < 100.5)
			{
				point.x = 100.5;
			}
			else if (point.x > 699.5)
			{
				point.x = 699.5;
			}
			
			if (_panel.interval == false)
			{
				_points.push(point);
			}
			else
			{	
				var nearestPoint:int = -1;
				
				for (var i:int; i < _points.length-1; i++)
				{
					if (_points[i].x > point.x)
					{
						if (nearestPoint == -1 || Math.abs(point.y - _points[nearestPoint].y) > Math.abs(point.y - _points[i].y))
						{
							nearestPoint = i;
						}
					}
				}
				
				_points.splice(nearestPoint+1, 0, point);
			}
			
			
			
			drawLevel();
		}
		
		private function onPreventClick(e:MouseEvent):void 
		{
			var target:LinePoint = e.currentTarget as LinePoint;
			
			if (_panel.interval)
			{
				return;
			}
			
			if (_selected != null)
			{
				_selected.unSelect();
			}
			if (_selected == target)
			{
				_selected = null;
				target.unSelect();
			}
			else
			{
				_selected = target;
				target.select();
			}
			
			_panel.setPoint(_selected);
			
			e.stopImmediatePropagation();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			_dragging = e.currentTarget as LinePoint;
		}
		
		public function drawLevel():void 
		{
			fRemoveDup(_points);
			
			if (_landScape != null && _landScape.stage)
			{
				_landScape.destroy();
				removeChild(_landScape);
			}
			_landScape = new Landscape(new EditorLevel(_points));
			_landScape.x = 100;
			_landScape.drawLevel();
			addChildAt(_landScape, 0);
		}
		
		public function get points():Vector.<LinePoint> 
		{
			return _points;
		}
		
		public function set points(value:Vector.<LinePoint>):void 
		{	
			for (var x:int; x < _points.length; x++)
			{
				if (_points[i].parent)
				{
					_pointSprite.removeChild(_points[i]);
				}				
			}
			
			_points = value;
			
			for (var i:int; i < value.length; i++)
			{
				value[i].addEventListener(MouseEvent.MOUSE_DOWN, onDown);
				value[i].addEventListener(MouseEvent.CLICK, onPreventClick);
				_pointSprite.addChild(value[i]);
			}
		}
		
		public function get pointSprite():Sprite 
		{
			return _pointSprite;
		}
	}
}