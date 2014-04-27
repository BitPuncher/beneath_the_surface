package;

import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import flixel.tile.FlxTilemap;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	private var player:FlxSprite;
	private var level:FlxTilemap;
	private var enemies:FlxGroup;
	private var timer:FlxTimer;
	private var timerText:FlxText;
	private var timeToWave:Int = 7;
	private var spawns:Array<FlxPoint>;

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{

		


		// // Set up the stage
		level = new FlxTilemap();

		// Here's a giant string because whatever Haxe says to do doesn't work
		var stage:String = "1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,";

		level.loadMap(stage, 'assets/images/basic-tiles.png');


		// Set up Player
		player = new FlxSprite();
		player.x = level.width / 2;
		player.y = level.height / 3;
		player.maxVelocity.x = 90;
		player.maxVelocity.y = 300;
		player.acceleration.y = 150;

		player.drag.x = 80;

		player.makeGraphic(7, 7, FlxColor.WHITE);

		// Enemy spawn locations
		spawns = new Array<FlxPoint>();
		spawns.insert(0, new FlxPoint(160, 270));
		spawns.insert(1, new FlxPoint(60, 220));
		spawns.insert(2, new FlxPoint(280, 220));

		// Enemies
		enemies = new FlxGroup();
		var enemy:Enemy = new Enemy(Math.floor(level.width / 2), Math.floor(level.height / 4));
		enemies.add(enemy);


		// Timer
		timer = new FlxTimer();
		timer.start(timeToWave, spawnWave, 0);
		timerText = new FlxText(level.width + 10, 10, 30, 1 + ":" + timer.elapsedTime);


		// Add all the things
		add(level);
		add(player);
		add(enemies);
		add(timerText);

		super.create();
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
		// updatePlayer(player);

		FlxG.collide(player, level);
		FlxG.collide(enemies, level);
		FlxG.collide(enemies, player);

		// secondsToWave = Math.floor(FlxG.elapsed) % timeToWave;
		timerText.text = (timer.elapsedLoops + 1) + ":" + Math.ceil(timer.timeLeft);


		updatePlayer(player);

		// This isn't working as intended for whatever reason. Might be its order in update. 
		// enemies.callAll('lookForPlayer', [player]);


		super.update();
	}

	private function updatePlayer(player:FlxSprite):Void
	{
		player.acceleration.x = 0;

		if (FlxG.keys.pressed.LEFT)
		{
			player.acceleration.x = -player.maxVelocity.x * 8;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			player.acceleration.x = player.maxVelocity.x * 8;
		}
		if (FlxG.keys.justPressed.UP && player.isTouching(FlxObject.FLOOR))
		{
			player.velocity.y = -player.maxVelocity.y / 2;
		}
		if (FlxG.keys.justPressed.X)
		{
			teleport(player, level);
		}
	}

	private function teleport(sprite:FlxSprite, level:FlxTilemap):FlxSprite
	{
		// if teleport is ready
		var destination:FlxPoint = getTeleportDestination(sprite.getScreenXY(), level);
		sprite.x = destination.x;
		sprite.y = destination.y;
		return sprite;
	}

	private function getTeleportDestination(origin:FlxPoint, container:FlxTilemap):FlxPoint
	{
		if (origin.y > container.height / 2)
		{
			return new FlxPoint(origin.x, container.height - origin.y);
		}
		else
		{
			return new FlxPoint(origin.x, -origin.y + container.height);
		}
	}

	private function spawnWave(timer:FlxTimer):Void
	{
		var spawn:FlxPoint = spawns[timer.elapsedLoops % 3];
		enemies.add(new Enemy(Math.round(spawn.x), Math.round(spawn.y)));
	}
}