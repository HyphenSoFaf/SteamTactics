package managers;

import cards.Arrow;
import cards.HexidecimalRange;
import cards.Card;
/**
 * ...
 * @author loki
 */
class Battle extends BaseManager
{
	private var challenger:Card;
	private var powerValue:Int;
	private var challengerLuck:Int;
	private var attackScore:Int;

	private var rest:Card;
	private var opponentLuck:Int;
	private var defenseValue:Int;
	private var defenseScore:Int;
		
	public function new() 
	{
		super(null);
		
	}
	
	public function Fight(attacker:Card, defender:Card):Card
	{
		this.challenger = attacker;
		this.rest = defender;
		this.phase1();
		return this.phase2();
	}

	private function phase1():Void
	{
		this.powerValue = challenger.power.randomNumber();
		this.challengerLuck = challenger.luck.randomNumber();
		this.opponentLuck  = rest.luck.randomNumber();
		this.getDefenseValue();
	}

	private function phase2():Card
	{
		this.attackScore = cast Math.abs(this.randomNumber(this.powerValue, this.challengerLuck));
		this.defenseScore = cast Math.abs(this.randomNumber(this.defenseValue, this.opponentLuck));
		if (attackScore > defenseScore)
		{
			challenger.Capture();
			rest.getCaptured(challenger);
			return rest;
		}
		else
		{
			rest.Capture();
			challenger.getCaptured(rest);
			return challenger;
		}
	}

	private function phase3():Card
	{
		var challegenerScore:Int = this.powerValue - this.attackScore;
		var restScore:Int = this.defenseValue - this.defenseScore;
		if (challegenerScore > restScore)
		{
			challenger.Capture();
			rest.getCaptured(challenger);
			return rest;
		}
		else
		{
			rest.Capture();
			challenger.getCaptured(rest);
			return challenger;
		}

	}

	private function getDefenseValue():Void
	{
		var temp:Int;
		switch(challenger.battleClass)
		{
			case 'P':
				this.defenseValue = rest.physicalDefense.randomNumber();
			case 'M':
				this.defenseValue = rest.magicalDefense.randomNumber();
			case 'F':
				this.defenseValue = rest.physicalDefense.randomNumber();
				temp = rest.magicalDefense.randomNumber();
				if (defenseValue < temp) { defenseValue = temp; }
			case 'A':
				this.defenseValue = rest.physicalDefense.randomNumber();
				temp = rest.magicalDefense.randomNumber();
				if (defenseValue < temp) { defenseValue = temp; }
				temp = rest.power.randomNumber();
				if (defenseValue < temp) { defenseValue = temp; }				
		}
	}

	private function randomNumber( max:Int, min:Int = 0):Int
	{
		return (Math.floor(Math.random() * (max - min +1)) + min);
	}
	
}