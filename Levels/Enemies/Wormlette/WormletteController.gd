extends Node2D

export var cooldown = 3;
export var hp = 10;
var target = null;

func _process(delta):
	$Wormlettes/Wormlette.hp = hp;
	$Wormlettes/Wormlette.target = target;
	$Wormlettes/Wormlette2.hp = hp;
	$Wormlettes/Wormlette2.target = target;
	$Wormlettes/Wormlette3.hp = hp;
	$Wormlettes/Wormlette3.target = target;

	if (hp <= 0): return;
	if (is_attacking()): return;
	if (target == null): return;
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
