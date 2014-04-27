package;

import flixel.FlxSprite;
import flixel.util.FlxMath;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.FlxG;

class Enemy extends FlxSprite {

	private var chaseSpeed:Int = 80;
	private var walkSpeed:Int = 60;

	override public function new(x:Int, y:Int, ?color:Int = FlxColor.RED, ?health = 150){
		super();

		this.x = x;
		this.y = y;

		this.maxVelocity.x = walkSpeed;
		this.maxVelocity.y = 300;
		this.acceleration.y = 150;

		this.health = health;


		this.makeGraphic(7, 7, color);
	}

	override public function update() {
		//switch facing if its about to go off a ledge or hit a wall?
		if (this.isTouching(FlxObject.WALL)) {
			this.facing *= -1;
		}

		//moves
		acceleration.x = facing * maxVelocity.x / 4;

		//Death
		if (health <= 0) {
			FlxG.sound.play("enemy_death");
		}

		super.update();
	}

	override public function destroy() {
		super.destroy();
	
	}

	public function lookForPlayer(player:FlxSprite):Void {
		var distanceFromPlayer:Float = FlxMath.getDistance(player.getScreenXY(), this.getScreenXY());

		if (Math.abs(distanceFromPlayer) < 40) {
			this.maxVelocity.x = chaseSpeed;
			if (player.x - this.x > 0){
				this.facing = FlxObject.RIGHT;
			}
			else {
				this.facing = FlxObject.LEFT;
			}
		}
		else {
			this.maxVelocity.x = walkSpeed;
		}
	}
}