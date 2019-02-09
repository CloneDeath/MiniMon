extends Path2D

var grass_scene = preload("res://Levels/Terrain/Grass/TallGrass/TallGrass.tscn");

func _ready():
	var length = self.curve.get_baked_length();
	for i in range(0, length, 6):
		var tuft = grass_scene.instance();
		add_child(tuft);
		$Path.offset = i;
		tuft.position += $Path.position;