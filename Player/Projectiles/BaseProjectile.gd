extends KinematicBody2D

var facing = 1;
export var speed = 64;

func _physics_process(delta):
	self.move_and_collide(Vector2(speed * facing * delta, 0));