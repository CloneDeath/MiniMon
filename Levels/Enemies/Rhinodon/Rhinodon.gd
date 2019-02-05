extends KinematicBody2D

var speed = -48;
var velocity = Vector2(0, 0);
var gravity = 128;

func _process(delta):
	if (speed < 0):
		$Sprite.scale = Vector2(1, 1);
	else:
		$Sprite.scale = Vector2(-1, 1);

func _physics_process(delta):
	velocity.y += gravity * delta;
	velocity.x = speed;
	velocity = self.move_and_slide(velocity, Vector2(0, -1));
	if (self.is_on_wall()):
		speed *= -1;