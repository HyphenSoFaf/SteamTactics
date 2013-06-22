package screens;

import eventdispatchers.APIHandler;
import events.APIEvents;
import haxe.Md5;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldType;
import nme.ui.Mouse;


/**
 * ...
 * @author loki
 */
class Login extends BaseMenu
{	
	private var passwordField:TextField;
	private var usernameField:TextField;
	
	private var apiHandler:APIHandler;
	
	public function new(game:Game) 
	{
		super(game);
		this.name = "Login";
		this.visible = false;
		apiHandler = new APIHandler();
		init();
	}
	
	private function init():Void
	{
		usernameField = createCustomTextField(200, 200, 200, 25);
		passwordField = createCustomTextField(200, 300, 200, 25);
		passwordField.displayAsPassword = true;
		this.addChild(this.placeButton(new Bitmap (nme.Assets.getBitmapData ("img/buttons.png")),  500, 300, doLogin, "Log In"));
	}
	
	override public function Show():Void 
	{
		//login('Chantell', 'password');
		super.Show();
	}
	
	private function doLogin(e:MouseEvent):Void
	{
		login(usernameField.text, passwordField.text);
	}
	
	private function createCustomTextField(x:Float, y:Float, width:Float, height:Float):TextField 
	{
		var result:TextField = new TextField();
		result.x = x; result.y = y;
		result.width = width; result.height = height;
		result.background = true;
		result.backgroundColor = 0xFFFFFF;
		result.textColor = 0xFF0000; 
 		result.type = TextFieldType.INPUT;
		addChild(result);
		return result;
	}
	
	private function login(user:String, password:String)
	{
		var hash:Dynamic<String> = {username: user, password:password};
		apiHandler.addEventListener(APIEvents.RESPONSE, isLoggedIn);
		apiHandler.POST("login", hash);
	}
	
	private function isLoggedIn(event:APIEvents):Void
	{
		var results:Dynamic = event.data;	
		if (results.data.logged_in)
		{
			var user = new Player(results.data.user.id,results.data.user.username, 0 );
			user.avatarURL = results.data.user.avatar;
			this.game.player = user;
		}
		this.Hide();
		this.game.menuManager.FindMenu('Main');
		this.game.menuManager.Show();
		this.game.menuManager.currentMenu.firstSeen();
	}
	
}