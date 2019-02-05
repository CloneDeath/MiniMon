extends Camera2D

export(bool) var FollowHorizontal = true;
export(bool) var FollowVertical = false;

var target: Node2D = null;

func _process(_delta):
	if (target == null): return;
	if (FollowHorizontal): self.position.x = target.position.x;
	if (FollowVertical): self.position.y = target.position.y;