extends KinematicBody2D

export var Speed = 8;

var facing = "right";
var action = "idle";

func _process(_delta):
	var target_animation = action + "_" + facing;
	if ($Animation.current_animation != target_animation):
		$Animation.play(target_animation);

func _physics_process(delta):
	var LEFT = Input.is_action_pressed("move_left");
	var RIGHT = Input.is_action_pressed("move_right");
	var dp = Vector2(int(RIGHT)-int(LEFT), 0);
	self.move_and_slide(dp * Speed);

	if (LEFT && !RIGHT):
		facing = "left";
	elif (RIGHT && !LEFT):
		facing = "right";

	if ((LEFT || RIGHT) && !self.is_on_wall()):
		action = "walk";
	else:
		action = "idle";
