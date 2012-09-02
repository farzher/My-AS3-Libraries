package com.farzher {
	import flash.display.DisplayObject;
	
	public class Math2 {
		
		public static const PI2:Number = Math.PI * 2;
		
		public static function randomInt(min:int, max:int):int {
			return Math.round(min + Math.random() * (max - min));
		}
		
		public static function randomElement(array:Array):* {
			return array[randomInt(0, array.length-1)];
		}
		
		public static function randomBool(chance:Number=0.5):Boolean {
        	return (Math.random() < chance) ? true : false;
        }
		
		public static function shortestAngle(a1:Number, a2:Number):Number {
			return Math.PI - Math.abs(Math.abs(a1 - a2) - Math.PI)
		}
		
		public static function radians(val:Number):Number {
			return val * Math.PI / 180;
		}
		
		public static function degrees(val:Number):Number {
			return val * 180 / Math.PI;
		}
		
		public static function angle(y:Number, x:Number):Number {
			y *= -1;
			var angle:Number = Math.atan2(y, x);
			if (y <= 0) angle += Math2.PI2;
			return angle;
		}
		
		public static function flashAngle(y:Number, x:Number):Number {
			return degrees(Math.atan2(y, x));
		}
	}
}