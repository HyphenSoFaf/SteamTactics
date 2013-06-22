package screens;

import nme.Assets;
import nme.display.MovieClip;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.events.MouseEvent;
/**
 * ...
 * @author loki
 */
class BaseMenu extends MovieClip
{
	private var game:Game;
	private var bitmap:Bitmap;
	
	private var testOutput:TextField;
	//public var choices:Array = new Array();
	//private var positions:Array = new Array()
	
	public function new(game:Game) 
	{
		super();
		this.start(game);
	}
		
	private function start(game:Game):Void
	{
		this.bitmap = new Bitmap (Assets.getBitmapData ("img/MainMenu.png"));
		this.testOutput = new TextField();
		this.game = game;
		this.addChild(bitmap);
	//	this.init();
	}
	public function Update(deltaTime:Int):Void
	{

	}

	public function HandleInput(keyCode:UInt):Void
	{

	}

	public function Unload():Void
	{
		Remove();
	}
	
	private function placeButton(bitmap:Bitmap, x:Int, y:Int, funct:Dynamic->Void, text:String = "Default"):Sprite
	{
		var bitmap:Bitmap = bitmap;
		bitmap.x = x;
		bitmap.y = y;

		var tf:TextFormat = new TextFormat();
		tf.font = "Verdana";
		tf.size = 16;
		tf.color = 0x0000FF;

		var textField:TextField = new TextField();
		textField.defaultTextFormat = tf;
		textField.text = text;
		textField.x = x;
		textField.y = y;
		textField.width = bitmap.width;
		textField.selectable = false;

		var container:Sprite = new Sprite();
		container.addChild(bitmap);
		container.addChild(textField);
		container.buttonMode = true;
		container.addEventListener(MouseEvent.CLICK, funct);

		return container;
	}
	
	private function Remove():Void
	{
		if(game.topClass.contains(this))
		{
			game.topClass.removeChild(this);
		}
	}

	public function Load():Void
	{
		game.topClass.addChild(this);
	}

	public function Show():Void
	{
		this.visible = true;
	}

	public function Hide():Void
	{
		this.visible = false;
	}
	
	public function Destroy():Void
	{
		game = null;
		bitmap = null;
	}
	
	public function firstSeen():Void
	{
		
	}
	
	public function getChildrenOf(target:Sprite):Array<MovieClip>
	{
	   var children:Array<MovieClip> = [];
	   for (i in 0...target.numChildren)
	   {
		  //children.push(target.getChildAt(i));
	   }
	   return children;
	}
	
}