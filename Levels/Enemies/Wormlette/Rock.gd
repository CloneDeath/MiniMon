extends KinematicBody2D

export(Vector2) var velocity = Vector2(64, -30);
var gravity = 128;

func _ready():
	$Sprite.frame = randi()%4;

func _process(delta):
	velocity.y += gravity * delta;
	var collision = self.move_and_collide(velocity * delta);
	if (collision):
		if (collision.collider.is_in_group("player")):
			collision.collider.damage(self);
		self.queue_free();