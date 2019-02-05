extends Camera2D

export(bool) var FollowHorizontal = true;
export(bool) var FollowVertical = false;

var target: Node2D = null;

func _process(_delta):
	if (target == null): return;
	if (FollowHorizontal): self.global_position.x = target.global_position.x;
	if (FollowVertical): self.global_position.y = target.global_position.y;