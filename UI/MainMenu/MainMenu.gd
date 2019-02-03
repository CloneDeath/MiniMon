extends Node2D

func _input(event):
	if (event.is_pressed()):
		$AnimationPlayer.play("goto game");
		$AudioStreamPlayer.play();