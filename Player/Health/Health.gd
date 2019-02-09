extends Node2D

export var Current = 5;
export var Max = 5;

func _process(_delta):
	for child in get_children():
		if !child.is_in_group("heart"): continue;
		child.Current = Current;
		child.Max = Max;