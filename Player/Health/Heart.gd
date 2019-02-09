extends Sprite

export var HeartNumber = 1;
export var Current = 5;
export var Max = 5;

func _process(_delta):
	self.visible = HeartNumber <= Max;
	self.frame = 0 if HeartNumber <= Current else 1;