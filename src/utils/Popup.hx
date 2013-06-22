package utils;

import nme.display.MovieClip;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.events.TextEvent;
import nme.events.TimerEvent;
import nme.text.TextField;
import nme.utils.Timer;
/**
 * ...
 * @author loki
 */
class Popup
{
	private var message:String;
	private var accept:Sprite;
	private var decline:Sprite;
	private var acceptFunct:Dynamic->Void;
	private var declineFunct:Dynamic->Void;
	private var timerFunct:Dynamic->Void;
	public var data:Hash<String>;
	private var seconds:Int;
	private var countDownTimer:Timer;
	private var textField:TextField
		
	public function new(message:String, acceptFunction:Dynamic->Void, declineFunction:Dynamic->Void, timerFunct:Dynamic->Void, data:Hash<String>, seconds:Int = 60) 
	{
		super();
		this.accept = new Sprite();
		this.decline = new Sprite();
		this.name = "popup";
		this.data = data;
		this.message = message;
		this.acceptFunct = acceptFunction;
		if (acceptFunct == null)
		{
			acceptFunct = defaultMouse;
		}
		this.declineFunct = declineFunction;
		this.timerFunct = timerFunct;
		this.seconds = seconds;
		if (this.timerFunct == null) {
			this.timerFunct = defaultTimer;
		}			
		this.countDownTimer = new Timer(1000, seconds);
		this.setupPopup();
		this.countDownTimer.addEventListener(TimerEvent.TIMER, countDown);
		this.countDownTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.timerFunct);			
	}

	private function countDown(event:TimerEvent):void
	{
		this.seconds --;
		textField.text = this.message + "\n Time: " + String(seconds);
	}

	private function setupPopup():void
	{
		textField = new TextField();
		textField.text = this.message + "\n Time: " + String(seconds);

		this.graphics.beginFill(0x00FF00);
		this.graphics.drawRect(0, 0, 200, 50);
		this.graphics.endFill();
		this.width = 200;
		this.height = 50;


		setupAccept();
		setupDecline();
		this.addChild(textField);
		this.addChild(accept);
		if (this.declineFunct != null) {
			this.addChild(decline);
		}
		if (this.timerFunct != null) {
			this.countDownTimer.start();
		}


	}

	private function setupDecline():void
	{
		var textField:TextField = new TextField();
		textField.text = "Decline";

		this.decline.x = this.width - this.decline.width - 40;
		this.decline.y = this.height - this.decline.height - 20;

		this.decline.addChild(textField);
		if(declineFunct != null){
			this.decline.addEventListener(MouseEvent.CLICK, declineFunct);
		}else{
			this.decline.addEventListener(MouseEvent.CLICK, defaultMouse);
		}
	}

	private function setupAccept():void
	{
		var textField:TextField = new TextField();
		textField.text = "Accept";

		this.accept.x = 0;
		this.accept.y = this.height - this.accept.height - 20;

		this.accept.addChild(textField);
		this.accept.addEventListener(MouseEvent.CLICK, acceptFunct);
	}

	public function defaultTimer(event:TimerEvent):void
	{
		destroy();
	}

	public function defaultMouse(event:MouseEvent):void
	{
		destroy();
	}

	public function destroy():void
	{
		accept.removeEventListener(MouseEvent.CLICK, acceptFunct);
		decline.removeEventListener(MouseEvent.CLICK, declineFunct);
		this.countDownTimer.removeEventListener(TimerEvent.TIMER, countDown);
		this.countDownTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, timerFunct);
		this.parent.removeChild(this);
	}
	
}