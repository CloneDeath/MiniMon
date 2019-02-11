extends Node2D

signal is_dead();

export var cooldown = 1;
export var hp = 10;
var target = null;

func _process(delta):
	self.target = null;
	for body in $PlayerDetection.get_overlapping_bodies():
		if (body.is_in_group("player")):
			self.target = body;
			break;
	if (self.hp <= 0): return;
	if (self.is_attacking()): return;
	if (self.target == null): return;

	for child in $Wormlettes.get_children():
		child.hp = self.hp;
		child.target = self.target;

	cooldown -= delta;
	if (cooldown <= 0):
		attack();

func attack():
	cooldown = (randi() % 1) + 1;
	var child_index = randi() % $Wormlettes.get_children().size();
	var child = $Wormlettes.get_children()[child_index];
	child.activate();

func is_attacking():
	for child in $Wormlettes.get_children():
		if child.is_attacking(): return true;
	return false;

func on_take_damage(amount):
	hp -= amount;

func _on_PlayerDetection_body_entered(body):
	if (body.is_in_group("player")):
		target = body;

func _on_Wormlette_is_dead():
	emit_signal("is_dead");
