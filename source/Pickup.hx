package;

import flixel.FlxSprite;

class Pickup extends FlxSprite {
	override public function new(x:Float, y:Float) {
		super();
		this.x = x;
		this.y = y;

		this.loadGraphic("pickup");

		this.acceleration.y = 400;
		this.velocity.y = -100;
	}

	override public function update() {
		super.update();
	}

	override public function destroy() {
		super.destroy();
	}
}