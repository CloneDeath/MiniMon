extends Area2D

signal next_level();
var enabled = true;

func _process(_delta):
	if (!enabled): return;
	for body in get_overlapping_bodies():
		if (body.is_in_group("player")):
			emit_signal("next_level");
			enabled = false;
			return;