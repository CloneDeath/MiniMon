extends Sprite

export var max_width = 6;

func _ready():
	randomize();
	var grass_type = randi() % (max_width + 1);
	if (grass_type == max_width):
		self.visible = false;
		return;
	self.frame = grass_type;
	self.position.x += randi() % (max_width - grass_type);