extends TileMap

export(String, FILE, "*.tscn") var CurrentScenePath;
export(PackedScene) var NextLevelScene;
signal load_scene(scene);

var player = null;
var next_level_loaded = false;

func _ready():
	for advancement in get_children():
		if (advancement.is_in_group("next_level")):
			advancement.connect("next_level", self, "next_level");

func next_level():
	if (next_level_loaded): return;
	var next_level = NextLevelScene.instance();
	next_level.add_player(player);
	emit_signal("load_scene", next_level);
	next_level_loaded = true;

func add_player(new_player):
	if (new_player.get_parent() != null):
		new_player.get_parent().remove_child(new_player);
	self.add_child(new_player);
	new_player.position = $LevelSpawn.position;
	$Camera.target = new_player;
	player = new_player;
	player.connect("restart_level", self, "restart_level");
	player.connect("replace_player", self, "replace_player");

func restart_level():
	var CurrentScene = load(CurrentScenePath);
	var next = CurrentScene.instance();
	player.get_parent().remove_child(player);
	player.CurrentHp = player.MaxHp;
	player.position = Vector2(0, 0);
	next.add_player(player);
	emit_signal("load_scene", next);

func replace_player(new_player):
	self.add_child(new_player);
	new_player.position = player.position;
	new_player.velocity = player.velocity;
	$Camera.target = new_player;
	player.queue_free();
	player = new_player;

func _process(_delta):
	$GUI/Health.Max = player.MaxHp;
	$GUI/Health.Current = player.CurrentHp;