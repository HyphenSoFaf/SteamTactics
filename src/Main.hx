package ;

import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author loki
 */

class Main extends Sprite 
{
	var inited:Bool;
	var gameFrameTimeLast:Int;
	var game:Game;
	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		game = new Game(this.stage, this);
		game.stageHeight = this.stage.stageHeight;
		game.stageWidth = this.stage.stageWidth;
		
		this.addEventListener(Event.ENTER_FRAME, this.Run);
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	function Run(e:Event):Void
	{
		var timeDiff:Int = Lib.getTimer() - this.gameFrameTimeLast;
		this.gameFrameTimeLast = Lib.getTimer();
		game.Update(timeDiff);
	}
	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = nme.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
