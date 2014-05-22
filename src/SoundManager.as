package  
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Automatic
	 */
	public class SoundManager 
	{
		private static var soundManager:SoundManager;
		public static function get instance():SoundManager
		{
			if (soundManager == null)
			{
				soundManager = new SoundManager();
			}
			return soundManager
		}
		
		private var _thrusterSoundTransform:SoundTransform;
		private var _thrusterSoundChannel:SoundChannel;
		private var _thrusterSound:Sound;
		
		
		public function SoundManager() 
		{
			_thrusterSound = new Assets.ThrusterSound() as Sound;	
			_thrusterSoundTransform = new SoundTransform(0);
			_thrusterSoundChannel = _thrusterSound.play(0, int.MAX_VALUE, _thrusterSoundTransform);			
		}
		
		public function changeThrustVolume(value:Number):void
		{
			_thrusterSoundTransform.volume = value;
			_thrusterSoundChannel.soundTransform = _thrusterSoundTransform;
		}
	}
}