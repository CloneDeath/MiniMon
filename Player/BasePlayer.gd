extends KinematicBody2D

export var Speed = 16;
export var JumpHeight = 75;
var gravity = 128;
var velocity = Vector2(0, 0);
var facing = "right";
var action = "idle";

func _process(_delta):
	var target_animation = action + "_" + facing;
	if ($Animation.current_animation != target_animation):
		$Animation.play(target_animation);

func _physics_process(delta):
	var LEFT = Input.is_action_pressed("move_left");
	var RIGHT = Input.is_action_pressed("move_right");
	var JUMP = Input.is_action_just_pressed("jump");
	var FALL = !Input.is_action_pressed("jump");
	velocity.x = (int(RIGHT)-int(LEFT)) * Speed;
	if (is_on_floor() && JUMP):
		velocity.y = -JumpHeight;
	if (!is_on_floor() && FALL && velocity.y < 0 && velocity.y > (-JumpHeight * 0.80)):
		velocity.y = 0;
	velocity.y += gravity * delta;
	velocity = self.move_and_slide(velocity, Vector2(0, -1));

	if (LEFT && !RIGHT):
		facing = "left";
	elif (RIGHT && !LEFT):
		facing = "right";

	if ((LEFT != RIGHT) && !self.is_on_wall() && self.is_on_floor()):
		action = "walk";
	elif (!self.is_on_floor()):
		if (velocity.y < 0): action = "jump_up";
		else: action = "jump_down";
	else:
		action = "idle";

