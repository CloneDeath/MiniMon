extends Node2D
var current_scene: Node = null;

func _ready():
	var main_menu_scene = preload("res://UI/MainMenu/MainMenu.tscn");
	var main_menu = main_menu_scene.instance();
	load_scene(main_menu);

func load_scene(scene: Node):
	if (current_scene != null):
		current_scene.queue_free();
	add_child(scene);
	scene.connect("load_scene", self, "load_scene");
	current_scene = scene;