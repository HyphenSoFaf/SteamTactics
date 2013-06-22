package cards;

/**
 * ...
 * @author loki
 */
class Arrow
{
	public var location:Array<String>;
	public var opposingArrows:Array<String>;
	
	public function new(location:Array<String>) 
	{
		this.location = location;
		this.attacks();
	}
	
	private function attacks():Void
	{
		for (value in location)
		{
			switch(value)
			{
				case "TOPLEFT": opposingArrows.push("BOTTOMRIGHT"); break;
				case "LEFT": opposingArrows.push("RIGHT");break;
				case "BOTTOMLEFT": opposingArrows.push("TOPRIGHT");break;
				case "TOP": opposingArrows.push("BOTTOM");break;
				case "BOTTOM": opposingArrows.push("TOP");break;
				case "TOPRIGHT": opposingArrows.push("BOTTOMLEFT");break;
				case "RIGHT": opposingArrows.push("LEFT");break;
				case "BOTTOMRIGHT": opposingArrows.push("TOPLEFT");break;
			}
		}
	}
	
}