extends Sprite

export var HeartNumber = 1;
export var Current = 5;
export var Max = 5;

func _process(_delta):
	self.visible = HeartNumber <= Max;
	if (HeartNumber <= self.Current):
		self.frame = 0;
	else:
		self.frame = 1;