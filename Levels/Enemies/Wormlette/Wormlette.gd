extends KinematicBody2D

signal is_damaged(amount);
signal is_dead();

var projectile_scene = preload("res://Levels/Enemies/Wormlette/Rock.tscn");

var hp = 10;
var target:Node = null;

func activate():
	if (target != null):
		if (target.global_position.x > self.global_position.x):
			$Sprite.scale.x = -1;
		else:
			$Sprite.scale.x = 1;
	$Animation.play("attack");

func shoot():
	var projectile = projectile_scene.instance();
	add_child(projectile);
	projectile.velocity.x *= -$Sprite.scale.x;
	projectile.global_position = $Sprite/RockHole.global_position;

func is_attacking():
	return $Animation.is_playing();

func damage(source):
	if ($Damage.is_playing()): return;
	hp -= source.damage;
	if (hp <= 0):
		$Damage.play("die");
	else:
		$Damage.play("hit");
		emit_signal("is_damaged", source.damage);

func emit_death():
	emit_signal("is_dead");