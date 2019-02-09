extends TileMap

signal load_scene(scene);

var player = null;

func add_player(new_player):
	get_node("LevelSpawn").add_child(new_player);
	get_node("Camera").target = new_player;
	player = new_player;

func _process(_delta):
	$GUI/Health.Max = player.MaxHp;
	$GUI/Health.Current = player.CurrentHp;