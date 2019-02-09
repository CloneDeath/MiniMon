extends Sprite

export var max_width = 6;

func _ready():
	randomize();
	var grass_type = get_grass_type();
	grass_type = min(grass_type, max_width + 1) - 1;

	if (grass_type == -1):
		self.visible = false;
		return;
	self.frame = grass_type - 1;
	self.position.x += randi() % (max_width - (grass_type - 1));

func get_grass_type():
	var roll = randi() % 3;
	if (roll == 0):
		return 0;
	else:
		return 1 + get_grass_type();