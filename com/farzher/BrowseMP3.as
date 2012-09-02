package com.farzher
{
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import com.farzher.org.audiofx.mp3.MP3FileReferenceLoader;
	import com.farzher.org.audiofx.mp3.MP3SoundEvent;
	
	/**
	 * Allow the user to browse their local disk for an MP3.
	 * This will be returned to you as a Sound class, along with information about the
	 * file, like filename.
	 * 
	 * @usage
	 * var browser:BrowseMP3 = new BrowseMP3;
	 * browser.browse(callback);
	 * 
	 * function callback(sound:Sound, fr:FileReference) {
	 *		fr.name; //song name
	 * 		sound.play(); //sound class
	 * }
	 */
	public class BrowseMP3
	{
		private var fr:FileReference;
		private var loader:MP3FileReferenceLoader;
		private var callback:Function;
		
		public function browse(callback:Function):void
		{
			this.callback = callback;
			fr = new FileReference();
			loader = new MP3FileReferenceLoader();
			
			fr.addEventListener(Event.SELECT, onSelect);
			loader.addEventListener(MP3SoundEvent.COMPLETE, onComplete);
			
			fr.browse([new FileFilter("mp3 files","*.mp3")]);
		}
		
		private function onSelect(e:Event):void {
			loader.getSound(fr);
		}
		
		private function onComplete(e:*):void {
			callback(e.sound, fr);
		}
	}
}