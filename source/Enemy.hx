package;

import flixel.FlxSprite;
import flixel.util.FlxMath;

class Enemy extends FlxSprite {

	private var facing:Int = 1;

	override public function create(x:Int, y:Int){
		this.x = x;
		this.y = y;

		maxVelocity.x = 60;
		maxVelocity.y = 300;
		acceleration.y = 150;

		super.create();
	}

	override public function update() {
		//switch facing if its about to go off a ledge?

		//moves
		acceleration.x = facing * maxVelocity.x / 4;

		super.update();
	}

	override public function destroy() {
		super.destroy();
	
	}

	public function lookForPlayer(player:FlxSprite):Void {
		var distanceFromPlayer:Int = FlxMath.getDistance(player.getScreenXY(), this.getScreenXY());

		if (distanceFromPlayer < 20) {
			this.facing = (player.x - this.x) % 1;
		}
	}
}