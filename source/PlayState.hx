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
import flixel.tweens.FlxTween;
import flixel.addons.weapon.FlxWeapon;
import flixel.system.FlxSound;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{

	private var player:FlxSprite;
	private var level:FlxTilemap;
	private var reds:FlxGroup;
	private var yellows:FlxGroup;
	private var timer:FlxTimer;
	private var timerText:FlxText;
	private var timeToWave:Int = 3;
	private var spawns:Array<FlxPoint>;
	private var teleportReady:Bool = true;
	private var teleportCooldown:Int = 2;
	private var teleportCooldownTimer:FlxTimer;
	private var weapon:FlxWeapon;
	private var facingConversion:Map<Int, Int>;
	private var pickups:FlxGroup;
	private var firingCost:Int = 5;
	private var resource:FlxSprite;
	private var maxResource:Int = 100;
	private var resourceBar:FlxBar;
	private var muteButton:FlxButton;
	private var muted:Bool = false;
	private var instructions:FlxText;
	private var controls:FlxSprite;
	private var arrows:FlxSprite;

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

		level.loadMap(stage, 'basic-tiles');


		// Set up Player
		player = new FlxSprite();
		player.x = level.width / 2;
		player.y = level.height / 3;
		player.maxVelocity.x = 90;
		player.maxVelocity.y = 300;
		player.acceleration.y = 150;
		player.facing = FlxObject.RIGHT;

		player.drag.x = 100;

		player.makeGraphic(7, 7, FlxColor.WHITE);

		// Enemy spawn locations
		spawns = new Array<FlxPoint>();
		spawns.insert(0, new FlxPoint(160, 270));
		spawns.insert(1, new FlxPoint(60, 220));
		spawns.insert(2, new FlxPoint(280, 220));
		spawns.insert(3, new FlxPoint(110, 60));
		spawns.insert(4, new FlxPoint(50, 110));
		spawns.insert(5, new FlxPoint(220, 110));

		// Enemies
		reds = new FlxGroup();
		yellows = new FlxGroup();
		// Reds

		// Yellows
		yellows.add(new Enemy(Math.floor(spawns[3].x), Math.floor(spawns[3].y), 100, "yellow", FlxColor.YELLOW));
		yellows.add(new Enemy(Math.floor(spawns[4].x), Math.floor(spawns[4].y), 100, "yellow", FlxColor.YELLOW));
		yellows.add(new Enemy(Math.floor(spawns[5].x), Math.floor(spawns[5].y), 100, "yellow", FlxColor.YELLOW));

		// Timers
		timer = new FlxTimer();
		timer.start(timeToWave, spawnWave, 0);
		timerText = new FlxText(level.width + 10, 10, 30, 1 + ":" + timer.elapsedTime);

		teleportCooldownTimer = new FlxTimer();

		// Bullets


		// Weapon
		weapon = new FlxWeapon("pistol", player);
		weapon.makePixelBullet(10);
		weapon.setBulletLifeSpan(0);
		weapon.setFireRate(250);
		weapon.setBulletSpeed(250);
		weapon.setFireCallback(loseResource, new FlxSound().loadEmbedded("fire_bullet"));

		facingConversion = new Map();
		facingConversion.set(FlxObject.DOWN, FlxWeapon.BULLET_DOWN);
		facingConversion.set(FlxObject.RIGHT, FlxWeapon.BULLET_RIGHT);
		facingConversion.set(FlxObject.LEFT, FlxWeapon.BULLET_LEFT);

		// Resource
		resource = new FlxSprite(0, 0);
		resource.visible = false;
		resourceBar = new FlxBar(level.width + 10, 30, FlxBar.FILL_LEFT_TO_RIGHT, 100, 15, resource, "health");

		// Pickups
		pickups = new FlxGroup();

		// Buttons
		instructions = new FlxText(level.width + 10, 60, 50, "Move: \n\n\n\n\nShoot: \n\nTeleport: \n\nMute:");
		arrows = new FlxSprite(level.width + 10 + 50, 60);
		arrows.loadGraphic("arrows");
		controls = new FlxSprite(level.width + 10 + 50 + 20, 100);
		controls.loadGraphic("controls");
		// muteButton = new FlxButton(level.width + 10, 50, "Mute", muteSound);

		// Add all the things
		add(level);
		add(player);
		add(reds);
		add(yellows);
		add(timerText);
		add(weapon.group);
		add(resourceBar);
		add(pickups);
		add(instructions);
		add(arrows);
		add(controls);
		// add(muteButton);


		FlxG.sound.muteKeys = ["M"];
		FlxG.sound.play('hunting_and_green', 5, true);

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
		FlxG.collide(reds, level);
		FlxG.collide(reds, player);
		FlxG.collide(yellows, level);
		FlxG.collide(yellows, player);
		FlxG.collide(weapon.group, reds, enemyHit);
		FlxG.collide(weapon.group, yellows, enemyHit);
		FlxG.collide(weapon.group, level, killBullet);
		FlxG.collide(pickups, level);
		FlxG.collide(pickups, player, gainResource);

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
			player.facing = FlxObject.LEFT;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			player.acceleration.x = player.maxVelocity.x * 8;
			player.facing = FlxObject.RIGHT;
		}
		if (FlxG.keys.justPressed.UP && player.isTouching(FlxObject.FLOOR))
		{
			player.velocity.y = -player.maxVelocity.y / 2;
			FlxG.sound.play("player_jump");
		}
		if (FlxG.keys.pressed.DOWN)
		{
			player.facing = FlxObject.DOWN;
		}
		if (FlxG.keys.justPressed.Z)
		{
			teleport(player, level);
		}
		if (FlxG.keys.pressed.C && playerHasResources())
		{
			weapon.setBulletDirection(facingConversion[player.facing], weapon.bulletSpeed);
			weapon.fire();
		}
	}

	private function teleport(sprite:FlxSprite, level:FlxTilemap):Bool
	{
		if (teleportReady) {
			teleportReady = false;
			teleportCooldownTimer.start(teleportCooldown, tpTimerFinished, 1);

			//shake the sprite or something
			FlxG.sound.play('teleport_start');
			var accel:Float = sprite.acceleration.y;
			sprite.acceleration.y = 0;

			function finishTeleport(tween:FlxTween):Void
			{
				FlxG.sound.play('teleport_end');
				var destination:FlxPoint = getTeleportDestination(sprite.getScreenXY(), level);
				sprite.x = destination.x;
				sprite.y = destination.y;
				sprite.acceleration.y = accel;
			}

			FlxTween.tween(sprite, {y: sprite.y - 10}, 1.3, {complete: finishTeleport});
			
			return true;
		}
		else {
			FlxG.sound.play('teleport_fail');
			return false;
		}
		
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

	// Bullet callbacks
	private function killBullet(bullet:FlxObject, object:FlxObject):Void
	{
		bullet.kill();
	}

	private function enemyHit(bullet:FlxObject, object:Enemy):Void
	{
		bullet.kill();
		object.hurt(50);

		if (object.health <= 0 && object.spawnsPickups) {
			pickups.add(new Pickup(object.x, object.y));
		}
	}


	private function playerHasResources():Bool
	{
		if (player.y < level.height / 2 || resource.health >= firingCost) {
			return true;
		}
		else {
			return false;
		}
	}

	// Resource callbacks
	private function gainResource(pickup:Pickup, player:FlxSprite):Void {
		pickup.kill();
		resource.health = FlxMath.bound(Math.round(maxResource / 3) + resource.health, 0, maxResource);
	}

	private function loseResource():Void
	{
		if (player.y > level.height / 2) {
			resource.health -= firingCost;
		}
	}

	// Timer callbacks
	private function spawnWave(timer:FlxTimer):Void
	{
		var spawn:FlxPoint = spawns[timer.elapsedLoops % 3];
		reds.add(new Enemy(Math.round(spawn.x), Math.round(spawn.y)));

		spawn = spawns[timer.elapsedLoops % 3 + 3];
		if (yellows.countLiving() < 3) {
			yellows.add(new Enemy(Math.round(spawn.x), Math.round(spawn.y), 100, "yellow", FlxColor.YELLOW));
		}
		
		FlxG.sound.play("enemy_spawn");
	}

	private function tpTimerFinished(timer:FlxTimer):Void
	{
		teleportReady = true;
	}

	// Sound

	private function muteSound():Void {
		if (FlxG.sound.muted) {
			FlxG.sound.resume();
			FlxG.sound.playMusic("hunting_and_green", 5, true);
		}
		else {
			FlxG.sound.pause();
		}
	}
}