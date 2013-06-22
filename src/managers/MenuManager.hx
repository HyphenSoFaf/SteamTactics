package managers;
import screens.BaseMenu;

/**
 * ...
 * @author loki
 */
class MenuManager extends BaseManager
{
	public var currentMenu:BaseMenu;
	private var menus:Array<BaseMenu>;
	
	public function new(game:Game) 
	{
		super(game);
		menus = new Array<BaseMenu>();
	}
	
	public function addMenu(menu:BaseMenu):Void
	{
		menus.push(menu);
		game.topClass.addChild(menu);
	}

	public override function Update(deltaTime:Int):Void
	{
		currentMenu.Update(deltaTime);
	}

	public function HandleInput(keyCode:UInt):Void
	{
		currentMenu.HandleInput(keyCode);
	}

	public function Hide():Void
	{
		currentMenu.Hide();
	}

	public function Show():Void
	{
		currentMenu.Show();
	}

	public function FindMenu(name:String):Void
	{
		for(index in 0...menus.length)
		{
			if(menus[index].name == name)
			{
				currentMenu = menus[index];
			}
		}
	}	
}