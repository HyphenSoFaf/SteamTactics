package boards;

import cards.Card;
import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;
import nme.geom.Point;
import nme.geom.Rectangle;

/**
 * ...
 * @author loki
 */
class Square extends Sprite
{
	public var position:Point;
	public var adjacentSquares:Hash<Point>;
	public var isOccupied:Bool;
	public var card:Card;
	public var image:Bitmap;
	public var element:String;
	
	public function new(position:Point, size:Int) 
	{
		super();
		this.adjacentSquares = new Hash<Point>();
		this.image = new Bitmap(Assets.getBitmapData('img/square.png'));
		this.addChild(image);
		this.position = position;
		
		//right
		if(this.position.x > 0){
			this.adjacentSquares.set('RIGHT',  new Point(this.position.x - 1, this.position.y));
		}
		//left
		if (this.position.x < size ) {
			this.adjacentSquares.set('LEFT', new Point(this.position.x + 1, this.position.y));
		}
		//top
		if(this.position.y > 0){
			this.adjacentSquares.set('TOP', new Point(this.position.x, this.position.y - 1));
		}
		//bottom
		if (this.position.y < size ) {
			this.adjacentSquares.set('BOTTOM', new Point(this.position.x, this.position.y + 1));
		}
		//topleft
		if(this.position.x > 0 &&this.position.y > 0){
			this.adjacentSquares.set('TOPLEFT', new Point(this.position.x - 1, this.position.y - 1));
		}

		//topright
		if(this.position.x < size &&this.position.y < size){
			this.adjacentSquares.set('TOPRIGHT', new Point(this.position.x + 1, this.position.y + 1));
		}

		//bottomleft
		if(this.position.x > 0 &&this.position.y < size){
			this.adjacentSquares.set('BOTTOMLEFT', new Point(this.position.x - 1, this.position.y + 1));
		}

		//bottomright
		if(this.position.x < size &&this.position.y > 0){
			this.adjacentSquares.set('BOTTOMRIGHT', new Point(this.position.x + 1, this.position.y - 1));
		}		
	}
	
	public function Update(deltaTime:Int):Void
	{

	}

	public function Occupied(c:Card):Void
	{
		this.card = c;
		isOccupied = true;
	}
	
}