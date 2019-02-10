extends KinematicBody2D

export(bool) var sleeping = false;

var velocity = Vector2(1, 0);
var target = Vector2();
var speed = 24;
var hp = 3;
var speed_multiplier = 1;

func _ready():
	self.target = self.position;

func _process(delta):
	update_target();
	if (sleeping):
		play_animation("hanging");
	else:
		play_animation("idle");
		move_towards_target(delta);

func play_animation(anim):
	if ($AnimationPlayer.current_animation == anim): return;
	$AnimationPlayer.play(anim);

func move_towards_target(delta):
	var desired = (self.target - self.position).normalized();
	var delta_angle = velocity.angle_to(desired);
	velocity = velocity.rotated(delta_angle * delta);
	var collision = self.move_and_collide(velocity * speed * delta * speed_multiplier);
	if (collision):
		velocity = velocity.bounce(collision.normal);
		if (collision.collider.is_in_group("player")):
			collision.collider.damage(self);

func update_target():
	for body in $PlayerDetection.get_overlapping_bodies():
		make_target_if_player(body);

func _on_PlayerDetection_body_entered(body):
	make_target_if_player(body);

func make_target_if_player(body):
	if (body.is_in_group("player")):
		self.target = body.position;
		sleeping = false;

func damage(source):
	if ($AnimationPlayer.current_animation == "hurt" || hp <= 0):
		return;

	hp -= 1;

	if (hp <= 0):
		$DamageAnimation.play("death");
		give_xp(3);
	else:
		$DamageAnimation.play("hurt");
	self.velocity = -(source.position - self.position).normalized();

func give_xp(amount):
	for player in get_tree().get_nodes_in_group("player"):
		player.call_deferred("give_xp", amount);

func scale_speed(multiplier):
	self.speed_multiplier = multiplier;
