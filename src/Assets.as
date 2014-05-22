/**
Suggested workflow:
- create a fontLibrary subfolder in your project (NOT in /bin or /src)
- for example: /lib/fontLibrary
- copy font files in this location
- create a FontLibrary class in the same location
- one font library can contain several font classes (duplicate embed and registration code)

FlashDevelop QuickBuild options: (just press Ctrl+F8 to compile this library)
@mxmlc -o bin/Assets.swf -static-link-runtime-shared-libraries=true -noplay
*/
package  
{
	import flash.display.Sprite;
	import flash.text.Font;
	
	/**
	 * Font library
	 * @author Automatic
	 */
	public class Assets extends Sprite 
	{
		[Embed(source='../lib/Vectorb.ttf'
		,fontFamily  ='VectorBattle'
		,fontStyle   ='normal' // normal|italic
		,fontWeight  ='normal' // normal|bold
		,unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E'
		,embedAsCFF='false'
		)]
		public static const VectorBattle:Class;
		
		[Embed(source='../lib/Thruster.mp3')]
        public static var ThrusterSound:Class;
        
		public function Assets() 
		{
			Font.registerFont(VectorBattle);
		}	
	}	
}