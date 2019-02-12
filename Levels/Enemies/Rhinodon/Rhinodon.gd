extends KinematicBody2D

export var Enabled = false;
var speed = -32;
var velocity = Vector2(0, 0);
var gravity = 128;

func _process(_delta):
	if (speed < 0):
		$Sprite.scale = Vector2(1, 1);
	else:
		$Sprite.scale = Vector2(-1, 1);

func _physics_process(delta):
	if (!Enabled): return;
	velocity.y += gravity * delta;
	velocity.x = speed;
	velocity = self.move_and_slide(velocity, Vector2(0, -1));
	if (self.is_on_wall()):
		speed *= -1;
		velocity.y = -20;
	execute_collision_triggers();

func execute_collision_triggers():
	for i in range(get_slide_count()):
		var col = get_slide_collision(i);
		if (col.collider.is_in_group("player")):
			col.collider.damage(self);

func spawn_deflection(source):
	var bounce = source.duplicate(DUPLICATE_SCRIPTS);
	bounce.velocity.x = -source.velocity.x / 2;
	bounce.velocity.y = -abs(source.velocity.x / 2);
	bounce.life = 0.3;
	bounce.source = self;
	get_parent().add_child(bounce);

func damage(source):
	if (sign(speed) != sign(source.velocity.x)):
		$DeflectSound.play();
		self.call_deferred("spawn_deflection", source);
		return;
	if ($AnimationPlayer.current_animation == "hurt"):
		return;
	self.velocity.y = -20;
	self.speed /= 2;
	self.collision_layer = 0;
	self.collision_mask = 0;
	$AnimationPlayer.play("hurt");
	give_xp(2);

func give_xp(amount):
	for player in get_tree().get_nodes_in_group("player"):
		player.call_deferred("give_xp", amount);

func _on_PlayerDetection_body_entered(_body):
	Enabled = true;
