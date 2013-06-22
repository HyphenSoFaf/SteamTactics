package boards;

import nme.display.Sprite;
import nme.display.Bitmap;
import nme.events.MouseEvent;
import nme.geom.Point;

import cards.Card;
import managers.Battle;
/**
 * ...
 * @author loki
 */
class Board extends Sprite
{
	private var size:Int;
	private var battleManager:Battle;
	
	public var squares:Array<Square>;
	public var cards:Array<Card>;
	
	public function new(size:Int) 
	{
		super();
		this.size = size;
		battleManager = new Battle();
		squares = new Array<Square>();
		cards = new Array<Card>();
		makeBoard();
	}
	
	public function Update(deltaTime:Int):Void
	{
		
	}
	
	private function makeBoard():Void
	{
		for (x in 0...this.size)
		{
			for (y in 0...this.size)
			{
				var square:Square = new Square(new Point(x, y), size);
				square.x  = x * (square.width + 10);
				square.y  = y * (square.height + 10);

				squares.push(square);
				this.addChild(square);
			}
		}
	}
	public function placeCard(c:Card, square:Square, funct:MouseEvent->Void):Void
	{
		if ( !square.isOccupied)
		{
			var index:Int = 0; //squares.indexOf(square);
			cards[index] = c;
			c.addEventListener(MouseEvent.CLICK, funct);
			square.Occupied(c);
			checkAdjacentSquares(square);
		}
	}

	private function checkAdjacentSquares(square:Square):Card
	{
		for (obj in square.adjacentSquares)
		{
			var adjacentSquare:Square = this.getSquareFromPosition(obj);
			if (adjacentSquare.isOccupied)
			{
				var adjacentCard:Card = adjacentSquare.card;
				var card:Card = square.card;
				for (direction in card.arrows[0].opposingArrows)
				{
					for (opposingDirection in adjacentCard.arrows[0].location)
					{
						if (direction == opposingDirection)
						{
							battleManager.Fight(card, adjacentCard);
							return null;
						}
					}
				}
				adjacentCard.Capture();
				card.getCaptured(adjacentCard);
				return null;
			}
		}
		return null;
	}

	public function addEventToSquare(funct:MouseEvent->Void):Void
	{
		for(square in squares)
		{
			square.addEventListener(MouseEvent.CLICK, funct);
		}
	}

	private function getSquareFromPosition(position:Point):Square
	{
		for(  square in squares)
		{
			if (square.position == position)
			{
				return square;
			}
		}
		return null;
	}
	
}