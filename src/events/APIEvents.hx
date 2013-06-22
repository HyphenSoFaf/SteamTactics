package events;

import nme.events.Event;
/**
 * ...
 * @author loki
 */
class APIEvents extends Event
{
	public static var RESPONSE:String = "Response";
	
	public var data:Dynamic;
	
	public function new(type:String, data:Dynamic) 
	{
		super(type, false, false );
		this.data = data;
	}
	
}