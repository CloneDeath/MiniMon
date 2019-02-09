extends KinematicBody2D

export(PackedScene) var Projectile;
export var Speed = 20;
export var JumpHeight = 75;
export var MaxHp = 39;
var hp = 39;
var gravity = 128;
var velocity = Vector2(0, 0);
var facing = "right";
var action = "idle";

func _ready():
	hp = MaxHp;

func _physics_process(delta):
	execute_velocity_update(delta);
	velocity = self.move_and_slide(velocity, Vector2(0, -1));
	execute_animation_update();
	execute_collision_triggers();
	execute_attack_update();
	execute_animation_update();

func execute_attack_update():
	var ATTACK = Input.is_action_just_pressed("attack");
	if (ATTACK && Projectile != null):
		var bullet = Projectile.instance();
		bullet.facing = 1 if self.facing == "right" else -1;
		bullet.source = self;
		self.get_parent().add_child(bullet);
		bullet.global_position = $Sprite/ProjectileSource.global_position;

func execute_velocity_update(delta):
	var LEFT = Input.is_action_pressed("move_left");
	var RIGHT = Input.is_action_pressed("move_right");
	var JUMP = Input.is_action_just_pressed("jump");
	var FALL = !Input.is_action_pressed("jump");
	velocity.x = (int(RIGHT)-int(LEFT)) * Speed;
	if (is_on_floor() && JUMP):
		velocity.y = -JumpHeight;
	if (!is_on_floor() && FALL && velocity.y < 0 && velocity.y > (-JumpHeight * 0.80)):
		velocity.y += 8 * gravity * delta;
	velocity.y += gravity * delta;

func execute_animation_update():
	var LEFT = Input.is_action_pressed("move_left");
	var RIGHT = Input.is_action_pressed("move_right");
	var ATTACK = Input.is_action_just_pressed("attack");
	if (LEFT && !RIGHT):
		facing = "left";
	elif (RIGHT && !LEFT):
		facing = "right";

	if (is_attacking() || ATTACK):
		action = "attack";
	elif ((LEFT != RIGHT) && !self.is_on_wall() && self.is_on_floor()):
		action = "walk";
	elif (!self.is_on_floor()):
		if (velocity.y < 0): action = "jump_up";
		else: action = "jump_down";
	else:
		action = "idle";

	var target_animation = action + "_" + facing;
	if ($Animation.current_animation != target_animation):
		$Animation.play(target_animation);

func execute_collision_triggers():
	for i in range(get_slide_count()):
		var col = get_slide_collision(i);
		if (col.collider.is_in_group("enemy")):
			self.damage(col.collider);

func damage(_source):
	$DamageAnimation.play("take damage");
	self.velocity.y = -20;

func is_attacking():
	return $Animation.is_playing() && ($Animation.current_animation == "attack_right" || $Animation.current_animation == "attack_left");
