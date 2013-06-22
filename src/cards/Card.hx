package cards;

import nme.display.Sprite;
import nme.display.Bitmap;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Assets;

/**
 * ...
 * @author loki
 */
class Card extends Sprite
{
	public var id:String;
	public var description:String;
	public var limit:Int;
	
	public var power:HexidecimalRange;
	public var magicalDefense:HexidecimalRange;
	public var physicalDefense:HexidecimalRange;
	public var luck:HexidecimalRange;
	public var battleClass:String;
	
	public var arrows:Array<Arrow>;
	
	public var captured:Bool;
	public var capturedCards:Array<Card>;
	
	public var cardImage:Sprite;
	public var cardFront:Sprite;//playable card front
	public var cardBack:Sprite;//clickable card back
	
	
	
	public function new(id:String, name:String, description:String, limit:Int, values:String) 
	{
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.limit = limit;
		
		capturedCards = new Array<Card>();
		var temp:Array<String> = values.split('');
		this.power = new HexidecimalRange(temp[0]);
		this.luck = new HexidecimalRange(temp[1]);
		this.battleClass = temp[2];
		this.physicalDefense = new HexidecimalRange(temp[3]);
		this.magicalDefense = new HexidecimalRange(temp[4]);
	}
	
	public function Update(deltaTime:Int):Void
	{
		
	}
	
	public function Switch():Void
	{
		captured = !captured;
	}

	public function getCaptured(card:Card):Void
	{
		capturedCards.push(card);
		for (item in card.capturedCards)
		{
			item.Switch();
		}
	}

	public function Capture():Void
	{
		captured = true;
	}

	public function Free():Void
	{
		captured = false;
	}

	private function setupCardFront():Void
	{

	}

	public function Hide():Void
	{

	}

	public function Show():Void
	{

	}
}