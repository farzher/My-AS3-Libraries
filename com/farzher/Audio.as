package com.farzher {
	
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import org.flixel.FlxTimer;
	/**
	 * Get information about the currently playing audio.
	 * Includes background music, but also any sound effects!
	 * 
	 * @usage
	 * Audio.update();
	 * if(Audio.mediumBeat()) {
	 * 		//There was just a beat!
	 * 		//Spawn a badguy or soemthing!
	 * }
	 */
	public class Audio {
		/**
		 * Keep track of recent sound level history, so we can more effectively track beats.
		 */
		private static var _volumeHistory:Array = [];
		private static const _historyLength:int = 5;
		
		private static var _volume:Number = 0;
		public static function get volume():Number { return _volume; }
		private static var _average:Number = 0;
		public static function get average():Number { return _average; }
		private static var _difference:Number = 0;
		public static function get difference():Number { return _difference; }
		
		/**
		 * Process the current audio.
		 * You should call this every frame! It won't lag you, I promise.
		 * @param	type Passed to SoundMixer.computeSpectrum(ba, type)
		 */
		public static function update(type:Boolean=false):void {
			_volume = getVolume(type);
			_average = getAverage();
			_difference = getDifference();
		}
		
		/**
		 * Returns true if a beat of specified volume just happened.
		 * You'll have to play around with this value a little.
		 * tinyBeat, mediumBeat, and bigBeat just call this with different values
		 * @param	difference Is the difference in (current sound level) - (recent history) > difference?
		 * @return
		 */
		public static function isDifference(difference:Number):Boolean {
			return _difference > difference;
		}
		//some common uses for isDifference
		public static function tinyBeat():Boolean {
			return isDifference(10);
		}
		public static function mediumBeat():Boolean {
			return isDifference(20);
		}
		public static function bigBeat():Boolean {
			return isDifference(30);
		}
		
		
		/**
		 * Want to visualize the audio?
		 * Here's a ByteArray of it. Look up how to render this as a sound wave or whatever.
		 * @param	type Passed to SoundMixer.computeSpectrum(ba, type)
		 * @return
		 */
		public static function getByteArray(type:Boolean = false):ByteArray {
			var ba:ByteArray = new ByteArray();
			SoundMixer.computeSpectrum(ba, type);
			return ba;
		}
		
		private static function getVolume(type:Boolean=false):Number {
			var ba:ByteArray = getByteArray(type);
			
			var volume:Number = 0;
			for(var i:uint=0; i<256; i++) {
				volume += Math.abs(ba.readFloat());
			}
			
			_volumeHistory.push(volume);
			while (_volumeHistory.length > _historyLength)
				_volumeHistory.shift();
			
			return volume;
		}
		
		private static function getAverage():Number {
			if (_volumeHistory.length == 0) return 0;
			
			var volume:Number = 0;
			for (var i:uint = 0; i < _volumeHistory.length; i++) {
				volume += _volumeHistory[i];
			}
			
			return volume / _volumeHistory.length;
		}
		
		private static function getDifference():Number {
			return _volume - _average;
		}
	}
}