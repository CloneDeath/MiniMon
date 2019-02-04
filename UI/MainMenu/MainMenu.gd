extends Node2D

var selection_scene = preload("res://UI/SelectMiniMon/SelectMiniMon.tscn");

func _ready():
	$MenuTheme.play();

func _input(event):
	if (event.is_pressed()):
		$AnimationPlayer.play("goto game");
		$AudioStreamPlayer.play();

func go_to_selection():
	get_tree().change_scene_to(selection_scene);