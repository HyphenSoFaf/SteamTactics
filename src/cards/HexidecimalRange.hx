package cards;

/**
 * ...
 * @author loki
 */
class HexidecimalRange
{
	private var rangeName:String;
	private var minimumValue:Int;
	private var maximumValue:Int;

	public function new(rangeName:String) 
	{
		this.rangeName = rangeName;
		this.getValue();
	}
	
	private function getValue():Void
		{
			switch (this.rangeName)
			{
				case '0':
					minimumValue = 000;
					maximumValue = 015;
				case '1':
					minimumValue = 016;
					maximumValue = 031;
				case '2':
					minimumValue = 032;
					maximumValue = 047;
				case '3':
					minimumValue = 048;
					maximumValue = 063;
				case '4':
					minimumValue = 064;
					maximumValue = 079;
				case '5':
					minimumValue = 080;
					maximumValue = 095;
				case '6':
					minimumValue = 096;
					maximumValue = 111;
				case '7':
					minimumValue = 112;
					maximumValue = 127;
				case '8':
					minimumValue = 128;
					maximumValue = 143;
				case '9':
					minimumValue = 144;
					maximumValue = 159;
				case 'A':
					minimumValue = 160;
					maximumValue = 175;
				case 'B':
					minimumValue = 176;
					maximumValue = 191;
				case 'C':
					minimumValue = 192;
					maximumValue = 207;
				case 'D':
					minimumValue = 208;
					maximumValue = 223;
				case 'E':
					minimumValue = 224;
					maximumValue = 239;
				case 'F':
					minimumValue = 240;
					maximumValue = 255;
			}
		}

		public function randomNumber():Int
		{
			return (Math.floor(Math.random() * (maximumValue - minimumValue +1)) + minimumValue);
		}
	
}