package editor 
{
	import com.bit101.components.Component;
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.bit101.components.TextArea;
	import com.bit101.utils.MinimalConfigurator;
	import editor.LinePoint;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Automatic
	 */
	public class EditPanel extends Sprite 
	{		
		private var config:MinimalConfigurator;
		
		private var main:editor.Main;
		private var selected:LinePoint;
		
		[Embed(source = '../../lib/LevelTemplate.txt', mimeType="application/octet-stream")]
		private var LEVEL_GENERATOR:Class;
		private var file:FileReference;
		
		public function EditPanel(main:editor.Main) 
		{
			addEventListener(Event.ADDED_TO_STAGE, onStage);
			
			graphics.beginFill(0xC0C0C0);
			graphics.lineStyle(2, 0x737373);
			graphics.drawRect(0, 0, 200, 480);
			graphics.endFill();
			
			this.main = main;
			
			this.addEventListener(MouseEvent.CLICK, onClick);
		}		
		
		private function onClick(e:MouseEvent):void 
		{
			e.stopImmediatePropagation();
		}
		
		private function onStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			//Component.initStage(stage);
			
			var xml:XML = <comps>
								<Panel x="10" y="10" width="180" height="100">
									<HBox x="10" y="10">
										<VBox>
											<Label text="x:"/>
											<Label text="y:"/>
										</VBox>
										<VBox spacing="7">
											<InputText id="x" x="50" />
											<InputText id="y" x="50" />
										   <PushButton label="Update" x="50" event="click:onUpdate"/>
										</VBox>
									</HBox>
								</Panel>
								<Panel x="10" y="120" width="180" height="40">
									<HBox x="10" y="10">
									   <VBox>
											<Label text="name:"/>
										</VBox>
										<VBox spacing="7">
											<InputText id="name" x="50" />
										</VBox>
									</HBox>
							   </Panel>
							   < Panel x = "10" y = "170" width = "180" height="320" >
									<TextArea id="classTemplate" width="500" height="250" />
									<PushButton label="generate" y ="260" x="0" event="click:onGenerate"/>
									<PushButton label="load" y ="260" x="80" event="click:loadLevel"/>
									<PushButton id="intervalId" toggle="true" label="interval"  y ="280" x="0"/>
									<PushButton toggle="true" label="hide" y ="280" x="80" event="click:hide"/>
							   </Panel>
							</comps>;
							
			config = new MinimalConfigurator(this);
			config.parseXML(xml);
		}
			
		public function hide(event:MouseEvent):void
		{
			main.pointSprite.visible = !main.pointSprite.visible;
		}
		
		public function onGenerate(event:MouseEvent):void
		{
			var string:String = new LEVEL_GENERATOR();
			
			string = string.split("FILL_NAME").join(InputText(config.getCompById("name")).text);
			
			var points:String = "";
				for (var i:int; i < main.points.length; i++)
				{
					if (i == main.points.length -1)
					{
						points += "new Point(" + (main.points[i].x-100) + ", " + main.points[i].y + ") \n";
					}
					else
					{
						points += "new Point(" + (main.points[i].x-100) + ", " + main.points[i].y + "), \n";
					}
				}
				
			string = string.split("\n").join("");
				
			string = string.split("FILL_POINTS").join(points);
			
			TextArea(config.getCompById("classTemplate")).text = string;
		}
		
		
		public function loadLevel(event:MouseEvent):void
		{
			file = new FileReference();
			file.browse();
			file.addEventListener(Event.SELECT, onFileSelected);
		}
		
		private function onFileSelected(e:Event):void 
		{
			file.addEventListener(Event.COMPLETE, onFileLoaded);
			file.load();
		}
		
		private function onFileLoaded(e:Event):void 
		{
			var classFile:String = e.target.data;
			
			var begin:int =	classFile.indexOf("/*START_POINTS*/") + "/*START_POINTS*/".length;
				
			var end:int =	classFile.indexOf("/*END_POINTS*/");
			
			var str:String = classFile.slice(begin, end);
			
			var points:Array = str.split("new Point(");
			
			var linePoints:Vector.<LinePoint> = new Vector.<LinePoint>();
			
			for (var i:int; i < points.length; i++)
			{
				var linePoint:LinePoint = new LinePoint();
				
				var comma:int = String(points[i]).indexOf(",");
				var carret:int = String(points[i]).indexOf(")");
					linePoint.x = Number(String(points[i]).slice(0, comma)) + 100;
					linePoint.y = Number(String(points[i]).slice(comma + 1, carret));
				linePoints.push(linePoint);
			}
			main.points = linePoints;
			
			main.drawLevel();
		}
		
		public function onUpdate(event:MouseEvent):void
        {
		   if (this.selected != null)
		   {
			   this.selected.x = Number(InputText(config.getCompById("x")).text);
			   this.selected.y = Number(InputText(config.getCompById("y")).text);
		   }
		   main.drawLevel();
        }
		
		public function setPoint(selected:LinePoint):void 
		{
			this.selected = selected;
			if (selected == null)
			{
				InputText(config.getCompById("x")).text = "";
				InputText(config.getCompById("y")).text = "";
			}
			else
			{
				InputText(config.getCompById("x")).text = selected.x.toString();
				InputText(config.getCompById("y")).text = selected.y.toString();
			}
		}
		
		public function get interval():Boolean
		{
			return PushButton(config.getCompById("intervalId")).selected;
		}
	}
}