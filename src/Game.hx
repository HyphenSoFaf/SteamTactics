package ;

import managers.MenuManager;
import screens.Login;
import utils.GameOptions;
import cards.Card;

import screens.MainMenu;
import screens.Store;
import screens.Play;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Stage;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.net.URLLoader;
import nme.net.URLRequest;
/**
 * ...
 * @author loki
 */
class Game
{
	public var topClass:Main;
	public var stage:Stage;
	public var player:Player;
	public var opponent:Player;
	
	public var cards:Hash<Card>;
	//public var sets:Hash<Set>;
	public var gameSettings:GameOptions;
	
	public var backGroundBitmapData:BitmapData;
	public var hudBitmapData:BitmapData;
	public var canvasBitmapData:BitmapData;
	public var canvasBitmap:Bitmap;
	
	public var isGameOver:Bool = true;
	public var menuManager:MenuManager;
	
	public var stageWidth:Int;
	public var stageHeight:Int;
	
	

	public function new(stage:Stage, topClass:Main) 
	{
		this.stage = stage;
		this.topClass = topClass;
		
		menuManager = new MenuManager(this);
		menuManager.addMenu(new MainMenu(this));		
		menuManager.addMenu(new Store(this));
		menuManager.addMenu(new Play(this));
		menuManager.addMenu(new Login(this));
		/*menuManager.addMenu(new CreateGame(this));
		menuManager.addMenu(new ChooseFriend(this));
		menuManager.addMenu(new Preload(this));
		*/
		menuManager.FindMenu("Main");//change this to preloader change main visibility to false
		menuManager.Show();
		init();

		topClass.addChild(canvasBitmap);
		topClass.stage.focus = topClass.stage;
		
	}
	
	public function init():Void
	{
		backGroundBitmapData = new BitmapData(640, 480, false, 0x000000);
		hudBitmapData = new BitmapData(640, 480, true, 0xffffff);
		canvasBitmapData = new BitmapData(640, 480, false, 0xffffff);
		canvasBitmap = new Bitmap(canvasBitmapData);
		canvasBitmap.visible = false;
	}
	
	public function Update(deltaTime:Int)
	{
		menuManager.Update(deltaTime);
	}
	
	public function SinglePlayer():Void
	{
		
	}
	
	public function PreGame():Void
	{
		canvasBitmap.visible = false;
	}
	
	public function PlayNow():Void
	{
		
	}
	
	public function StartGame():Void
	{
		isGameOver = false;
		canvasBitmap.visible = true;
		topClass.stage.focus = topClass.stage;
		//menuManager.Hide();
	}
	
	public function EndGame():Void
	{
		topClass.removeChild(canvasBitmap);
	}
	
}