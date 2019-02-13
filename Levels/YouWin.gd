extends Node2D

#warning-ignore:unused_signal
signal load_scene(scene);

func _on_Patreon_pressed():
	OS.shell_open("https://www.patreon.com/clonedeath");
