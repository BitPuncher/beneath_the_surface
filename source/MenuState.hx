package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	private var title:FlxSprite;
	private var press:FlxButton;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();

		title = new FlxSprite(0, 0);
		title.loadGraphic("title");

		press = new FlxButton(title.width / 2, title.height, "Press to Start", startGame);
		press.width = press.width * 2;

		FlxG.sound.muteKeys = ["M"];

		FlxG.sound.playMusic("a_black_horse", 5, true);

		add(title);
		add(press);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	

	private function startGame():Void {
		FlxG.sound.pause();
		FlxG.switchState(new PlayState());
	}

}