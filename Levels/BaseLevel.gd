extends TileMap

export(String, FILE, "*.tscn") var CurrentScenePath;
signal load_scene(scene);

var player = null;

func add_player(new_player):
	get_node("LevelSpawn").add_child(new_player);
	get_node("Camera").target = new_player;
	player = new_player;
	player.connect("restart_level", self, "restart_level");

func restart_level():
	var CurrentScene = load(CurrentScenePath);
	var next = CurrentScene.instance();
	player.get_parent().remove_child(player);
	player.CurrentHp = player.MaxHp;
	player.position = Vector2(0, 0);
	next.add_player(player);
	emit_signal("load_scene", next);

func _process(_delta):
	$GUI/Health.Max = player.MaxHp;
	$GUI/Health.Current = player.CurrentHp;