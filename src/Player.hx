package ;

import cards.Card;
import nme.display.Bitmap;
import nme.display.Loader;
import nme.display.Shape;
import nme.display.Sprite;
import nme.text.TextField;
/**
 * ...
 * @author loki
 */
class Player
{
	public var id:String;
	public var name:String;
	public var avatarURL:String;
	public var avatar:Loader;
	public var money:Float;
	
	public var challenged:Bool;
	
	public var hand:Array<Card>;
	
	public function new(id:String, name:String, money:Float) 
	{
		this.id = id;
		this.name = name;
		this.money = money;
		hand = new Array<Card>();
	}
	
	public function createButton(x:Int, y:Int):Sprite
	{
		var textField:TextField = new TextField();
		textField.text = this.name;
		textField.selectable = false;

		var button:Sprite = new Sprite();
		button.buttonMode = true;

		button.graphics.beginFill(0xFF0000);
		button.graphics.drawRect(0, 0, 200, 25);
		button.graphics.endFill();

		button.addChild(textField);
		return button;
	}

	public function addCard(c:Card):Void
	{
		hand.push(c);
	}

	public function removeCard(c:Card):Void
	{
		var index:Int = 0;//hand.indexOf(c);
		hand.splice(index, 1);
	}

	public function getScore():Int
	{
		/*var cardsCaptured:int = 0;
		for ( var card:Card in hand)
		{
			if(!card.captured)
				cardsCaptured += card.capturedCards.length;
		}
		return cardsCaptured;*/
		return 0;
	}	
}