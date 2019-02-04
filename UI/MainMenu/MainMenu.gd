extends Node2D

signal load_scene(node);

var selection_scene = preload("res://UI/SelectMiniMon/SelectMiniMon.tscn");

func _ready():
	$MenuTheme.play();

func _input(event):
	if (event.is_pressed() && !$AnimationPlayer.is_playing()):
		$AnimationPlayer.play("goto game");
		$AudioStreamPlayer.play();

func go_to_selection():
	emit_signal("load_scene", selection_scene.instance());