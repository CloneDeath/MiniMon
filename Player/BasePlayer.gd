extends KinematicBody2D

signal restart_level();
signal replace_player(new_player);

export(PackedScene) var Projectile;
export(PackedScene) var MiniVolution;
#warning-ignore:unused_class_variable
export(String) var MinimonName = "Minimon";
export(int) var XpNeeded = 5;
export var Speed = 20;
export var JumpHeight = 75;
export var MaxHp = 3;
export var Damage = 1;
var CurrentHp = 3;
var gravity = 128;
var velocity = Vector2(0, 0);
var facing = "right";
var action = "idle";
var Xp = 0;

func _ready():
	CurrentHp = MaxHp;

func _physics_process(delta):
	execute_velocity_update(delta);
	velocity = self.move_and_slide(velocity, Vector2(0, -1));
	execute_animation_update();
	execute_collision_triggers();
	execute_attack_update();
	execute_animation_update();

func execute_attack_update():
	if (is_dead()): return;
	var ATTACK = Input.is_action_just_pressed("attack");
	if (ATTACK && Projectile != null):
		var bullet = Projectile.instance();
		bullet.velocity.x *= 1 if self.facing == "right" else -1;
		bullet.source = self;
		bullet.damage = self.Damage;
		self.get_parent().add_child(bullet);
		bullet.global_position = $Sprite/ProjectileSource.global_position;

func execute_velocity_update(delta):
	velocity.y += gravity * delta;

	if (is_dead()): return;
	var LEFT = Input.is_action_pressed("move_left");
	var RIGHT = Input.is_action_pressed("move_right");
	var JUMP = Input.is_action_just_pressed("jump");
	var FALL = !Input.is_action_pressed("jump");
	velocity.x = (int(RIGHT)-int(LEFT)) * Speed;
	if (is_on_floor() && JUMP):
		velocity.y = -JumpHeight;
	if (!is_on_floor() && FALL && velocity.y < 0 && velocity.y > (-JumpHeight * 0.80)):
		velocity.y += 8 * gravity * delta;

func execute_animation_update():
	if (is_dead()): return;
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
	if $DamageAnimation.is_playing(): return;
	if (is_dead()): return;
	self.CurrentHp -= 1;
	if (self.CurrentHp <= 0):
		$Animation.play("die_" + facing);
		velocity.x = 0;
	else:
		$DamageAnimation.play("take damage");
		self.velocity.y = -20;

func is_attacking():
	return $Animation.is_playing() && ($Animation.current_animation == "attack_right" || $Animation.current_animation == "attack_left");

func is_dead():
	return self.CurrentHp <= 0;

func restart_level():
	emit_signal("restart_level");

func give_xp(amount):
	Xp += amount;
	if (Xp >= XpNeeded && MiniVolution != null):
		var next = MiniVolution.instance();
		emit_signal("replace_player", next);