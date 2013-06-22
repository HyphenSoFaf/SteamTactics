package screens;

import nme.display.Shape;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.net.URLLoader;
import nme.net.URLRequest;
import haxe.Json;
import nme.text.TextField;

import utils.Scrollbar;
/**
 * ...
 * @author loki
 */
class Store extends BaseMenu
{

	private var selectedSet:Int;
	private var loader:URLLoader;
	private var urlRequest:URLRequest;
	
	
	private var container:Sprite;
	private var setMask:Sprite;
	private var left:Sprite;
	private var right:Sprite;
	private var positions:Array<Dynamic>;
	private var sets:Array<Dynamic>;
	private var slider:Scrollbar;
	public var player:Player;
	
	private var scrollAmount:Int;
		
	public function new(game:Game) 
	{
		super(game);
		this.name = "Store";
		this.visible = false;
		this.loader = new URLLoader();
		this.urlRequest = new URLRequest();
		positions = new Array<Dynamic>();
		container = new Sprite();
		//loadSets();
	}
	
	private function loadSets():Void
	{
		urlRequest.url = "";
		loader.addEventListener(Event.COMPLETE, getSets);
		loader.load(urlRequest);
	}
	
	private function getSets(event:Event):Void
	{
		sets = Json.parse(event.target.data);
	}
	
	public override function Show():Void
	{
		super.Show();
		showCards();
		displayPlayerInfo();
		createSlider();
	}
	
	public function displayPlayerInfo():Void
	{
		var playerName:TextField = new TextField();
		var playerMoney:TextField = new TextField();
		
		playerName.text = game.player.name;
		playerMoney.text = Std.string(game.player.money);
		
		playerName.y = 100;
		playerMoney.y = 125;
		
		this.addChild(playerName);
		this.addChild(playerMoney);		
	}
	
	private function createSlider():Void 
	{
		var mask:Shape = new Shape();
		mask.graphics.beginFill(0x000000);
		mask.graphics.drawRoundRect(0, 0, 520, 70, 15);
		mask.graphics.endFill();
		container.mask = mask;
		container.y = mask.y = 250;
		slider = new Scrollbar(game, container, mask);
		addChild(container);
		addChild(slider);

	}

	override public function Update(deltaTime:Int):Void 
	{
		super.Update(deltaTime);
		slider.Update(deltaTime);
	}


	private function showCards():Void
	{		
		for (index in 0...105/*sets.length*/)
		{
			var sprite:Sprite = new Sprite();
			//var object:Object = sets[0];

			//sprite.graphics.beginBitmapFill(this.game.Sets[object.id].bitmapData);
			sprite.graphics.beginFill(0x252525);
			sprite.graphics.drawRect(0, 0, 50,70);
			sprite.graphics.endFill();
			sprite.x  = index * (sprite.width + 10);
			//sprite.addEventListener(MouseEvent.CLICK, getSet);
			positions.push(sprite);
			container.addChild(sprite);
		}
	}

	private function getSet(event:MouseEvent):Void
	{
		//var index:Int = positions.indexOf(event.target);
		//trace(sets[index].id);

	}
}