extends Area2D

export var speed = 64;

var facing = 1;
var source: Node = null;

func _physics_process(delta):
	self.position.x += speed * facing * delta;
	$Sprite.scale.x = facing;

func _on_BaseProjectile_body_entered(body):
	if (body == source): return;
	if (body.has_method("damage")):
		body.damage(self);
	self.queue_free();
