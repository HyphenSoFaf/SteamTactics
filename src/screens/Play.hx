package screens;

import boards.Square;
import boards.Board;
import cards.Card;
import nme.Assets;
import utils.GameOptions;

import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.geom.Matrix;
import nme.geom.Point;
import nme.text.TextField;
/**
 * ...
 * @author loki
 */
class Play extends BaseMenu
{
	public var player:Player;
	public var opponent:Player;
	private var board:Board;
	private var options:GameOptions;
	
	private var selectedCard:Card;
	private var selectedSquare:Square;
	
	private var playerHand:Sprite;
	private var playerInfo:Sprite;
	private var opponentInfo:Sprite;
	
	public function new(game:Game) 
	{
		super(game);
		this.name = "Play";
		this.visible = false;
		this.gameSettings = this.game.gameSettings;
	}

	override private function start(game:Game):Void 
	{
		//super.start();
		this.bitmap = new Bitmap(Assets.getBitmapData('img/board.png'));
		this.game = game;
		this.addChild(bitmap);
		//this.init();
	}

	override public function Show():Void 
	{
		super.Show();
		initialize();
	}

	private function initialize():Void
	{
		this.positionContainer();
		playerHand = new Sprite();
		this.setupPlayer(player, playerHand);
		this.playerHand.x = 200;
		this.playerHand.y = this.game.stageHeight - playerInfo.height;
		this.addChild(this.playerHand);
		this.setupBoard();
	}

	private function positionContainer():Void
	{
		playerInfo = new Sprite();
		opponentInfo = new Sprite();
		playerInit(player, playerInfo);
		playerInit(opponent, opponentInfo);
		playerInfo.y = this.game.stageHeight - playerInfo.height;
		this.addChild(playerInfo);
		this.addChild(opponentInfo);
	}
	
	private function playerInit(player:Player, container:Sprite):Void
	{
	//	var avatar:Bitmap = player.avatar.content;
		var name:TextField = new TextField();
		name.text = player.name;
		var score:TextField = new TextField();
		score.name = "score";
		score.text = "Cards Captured: " + player.getScore();

		name.x = 51;
		name.width = 50;
		score.x = 102;
		score.width = 100;

		//container.addChild(avatar);
		container.addChild(name);
		container.addChild(score);
	}

	private function setupPlayer(player:Player, container:Sprite):Void
	{
		//hand is bottom			
		for (index in 0...player.hand.length)
		{
			var card:Card = player.hand[index];


			card.x  = index * card.width;
			if (player == this.opponent)
			{
				rotateAroundCenter(card, 180);
			}
			else
			{
				card.addEventListener(MouseEvent.CLICK, selectCard);
			}

			container.addChild(card);
		}
	}

	private function setupBoard():Void
	{
		//in the middle
		this.board = new Board(4);
		this.board.addEventToSquare(selectSquare);
		this.board.x = 250;
		this.board.y = 70;
		this.addChild(this.board);
	}

	private function selectCard(event:MouseEvent):Void
	{
		this.selectedCard = cast(event.currentTarget, Card);
		if (this.selectedSquare != null)
		{
			selectedCard.removeEventListener(MouseEvent.CLICK, selectCard);
			selectedSquare.removeEventListener(MouseEvent.CLICK, selectSquare);
			board.placeCard(selectedCard, selectedSquare, showInfo);

			this.selectedCard = null;
			this.selectedSquare = null;
		}
		this.showInfo();
	}

	private function selectSquare(event:MouseEvent):Void
	{
		this.selectedSquare = cast(event.currentTarget, Square);
		if (this.selectedCard != null)
		{
			selectedSquare.removeEventListener(MouseEvent.CLICK, selectSquare);
			selectedCard.removeEventListener(MouseEvent.CLICK, selectCard);
			board.placeCard(selectedCard, selectedSquare, showInfo);

			this.selectedCard = null;
			this.selectedSquare = null;
		}
	}

	private function showInfo(event:MouseEvent = null):Void
	{
		// TODO implement
	}

	private function win():Void
	{
		this.gameOver(this.player, this.opponent);
	}

	private function lose():Void
	{
		this.gameOver(this.opponent, this.player);
	}

	private function gameOver(winner:Player, loser:Player):Void
	{
		//send to appropiate screen
		this.Hide();
		/*this.game.MenuMange.FindMenu('GameOver');
		this.game.MenuMange.Show();
		this.game.MenuMange.CurrentMenu.firstSeen();*/
	}

	private function rotateAroundCenter (ob:Sprite, angleDegrees:Int):Void
	{
		var point:Point = new Point(ob.x + ob.width / 2, ob.y + ob.height / 2);
		var m:Matrix=ob.transform.matrix;
		m.tx -= point.x;
		m.ty -= point.y;
		m.rotate(angleDegrees*(Math.PI/180)); // was a missing "=" here
		m.tx += point.x;
		m.ty += point.y;
		ob.transform.matrix=m;
	}
	
}