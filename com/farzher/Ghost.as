package com.farzher {
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	/**
	 * Record information about a player's run, that you can use to create a ghost image with
	 * 
	 * @usage
	 * //To record a run
	 * var ghost:Ghost = new Ghost();
	 * ghost.record(milisecondsPassed, {x:player.x, y:player.y};
	 * 
	 * //To playback a ghost
	 * var history:Object = ghost.playback(milisecondsPassed);
	 * ghostSprite.x = history.x;
	 * ghostSprite.y = history.y
	 */
	public class Ghost {
		
		private var history:Dictionary;
		
		function Ghost() {
			history = new Dictionary();
		}
		
		public function record(ms:Number, data:Object):void {
			history[ms] = data;
		}
		
		public function playback(ms:Number):Object {
			var historyObject:Object = this.getHistory(ms);
			return historyObject;
		}
		
		private function getHistory(ms:Number):Object {
			var closest:* = null;
			for (var key:* in history) {
				key = Number(key);
				if (key > ms) {
					continue;
				} else
				if (closest == null) {
					closest = key;
				} else
				if (key > closest) {
					closest = key;
				}
			}
			
			if (closest == null) {
				return null;
			} else {
				return history[closest];
			}
		}
		
	}
}