extends Sprite

export(PackedScene) var minimon;

signal minimon_selected(minimon);

func _ready():
	$Animation.play("idle");

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.is_pressed()):
		emit_signal("minimon_selected", minimon);