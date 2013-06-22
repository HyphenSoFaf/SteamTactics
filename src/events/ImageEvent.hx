package events;

import flash.events.Event;

/**
 * ...
 * @author loki
 */
class ImageEvent extends Event
{
	public static const IMAGELOADED:String = "Image Loaded";
	public static const IMAGEPROGRESS:String = "Image Progress";

	public var Data:Hash<String>;
		
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false, data:Hash<String>) 
	{
		super(type, bubbles, cancelable);
		
	}
	
}