package events;

import flash.events.Event;

/**
 * ...
 * @author loki
 */
class CustomEvents extends Event
{
	public static var BEGIN_GAME:String = "Begin Game";
	public static var END_GAME:String = "END Game";
	public static var CHOOSE_CARDS:String = "Choose Cards";
	public static var PLAYER_ADDED:String = "Player Added";
	public static var CHALLENGE_ACCEPTED:String = "Challenge Accepted";
	public static var CHALLENGE_DENIED:String = "Challenge Denied";
	public static var CHALLENGED:String = "Challenged"

	public var data:String;
		
	public function new(type:String, data:String = null) 
	{
		super(type, false, false );
		this.data = data;
	}
	
}