extends "res://Levels/BaseLevel.gd"

var you_win_scene = load("res://Levels/YouWin.tscn");
func go_to_next_level():
	var you_win = you_win_scene.instance();
	emit_signal("load_scene", you_win);