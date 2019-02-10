extends Node2D

signal load_scene(node);
var level01_scene = preload("res://Levels/Level01.tscn");

func minimon_selected(minimon: PackedScene):
	var player = minimon.instance();
	var level01 = level01_scene.instance();
	level01.add_player(player);
	emit_signal("load_scene", level01);