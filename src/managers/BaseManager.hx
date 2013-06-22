package managers;

/**
 * ...
 * @author loki
 */
class BaseManager
{
	private var updateTimeTally:Int;
	private var updateInterval:Int;
	private var game:Game;
	
	public function new(game:Game) 
	{
		this.game = game;
	}
	
	public function Update(deltaTime:Int):Void
	{
		this.updateTimeTally = this.updateTimeTally + deltaTime;
	}
	
}