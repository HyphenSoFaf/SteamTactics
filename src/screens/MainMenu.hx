package screens;

import nme.Assets;
import nme.display.Shape;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import cards.Card;

/**
 * ...
 * @author loki
 */
class MainMenu extends BaseMenu
{
	private var single:Sprite;
	private var playnow:Sprite;
	private var storeButton:Sprite;
	private var loginButton:Sprite;
	
	public function new(game:Game) 
	{
		super(game);
		this.name = "Main";
		this.visible = false;
		single = this.placeButton(new Bitmap (Assets.getBitmapData ("img/buttons.png")),  500, 360, singlePlayer, "Single Player");
		playnow = this.placeButton(new Bitmap (Assets.getBitmapData ("img/buttons.png")),  500, 420, createGame, "Play Now");
		storeButton = this.placeButton(new Bitmap (Assets.getBitmapData ("img/buttons.png")),  500, 480, store, "Store");
		loginButton = this.placeButton(new Bitmap (Assets.getBitmapData ("img/buttons.png")),  500, 300, login, "Log In");
		
		this.addChild(loginButton);
		this.addChild(single);
		this.addChild(playnow);
		this.addChild(storeButton);
		playnow.visible = false;
		storeButton.visible = false;
		loginButton.visible = false;
	}
	
	override public function Show():Void 
	{
		if (this.game.player != null)
		{
			playnow.visible = true;
			storeButton.visible = true;
		}else {
			loginButton.visible = true;
		}
		super.Show();
	}
	
	override public function Hide():Void 
	{
		playnow.visible = false;
		storeButton.visible = false;
		loginButton.visible = false;
		super.Hide();
	}
	
	private function login(evt:MouseEvent):Void
	{
		this.removeEventListener(MouseEvent.CLICK, login);
		this.Hide();
		this.game.menuManager.FindMenu('Login');
		this.game.menuManager.Show();
		this.game.menuManager.currentMenu.firstSeen();
	}
	
	private function createGame(evt:MouseEvent):Void
	{
		this.removeEventListener(MouseEvent.CLICK, createGame);
		this.Hide();
		/*this.game.menuManager.FindMenu('Create Game');
		this.game.menuManager.Show();
		this.game.menuManager.currentMenu.firstSeen();*/
	}

	private function singlePlayer(evt:MouseEvent):Void
	{
		this.removeEventListener(MouseEvent.CLICK, singlePlayer);
		this.Hide();
		this.game.menuManager.FindMenu('Play');
		var play:Play = cast(this.game.menuManager.currentMenu, Play);
		play.player = this.game.player;
		play.opponent = new Player("987654", "Search", 110);
		play.opponent.addCard(new Card('546325', "Stuff", "Another Test", 1, "34P46"));
		this.game.menuManager.Show();			
		this.game.menuManager.currentMenu.firstSeen();
	}

	private function store(evt:MouseEvent):Void
	{
		this.removeEventListener(MouseEvent.CLICK, store);
		this.Hide();
		this.game.menuManager.FindMenu('Store');
		this.game.menuManager.Show();
		this.game.menuManager.currentMenu.firstSeen();
	}
}