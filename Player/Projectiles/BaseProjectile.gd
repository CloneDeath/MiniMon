extends Area2D

export var life = 0.75;
#warning-ignore:unused_class_variable
export var damage = 1;

var velocity = Vector2(64, 0);

var source: Node = null;
var splash_scene = load("res://Player/Projectiles/Splash.tscn");

func _physics_process(delta):
	self.position += velocity * delta;
	$Sprite.scale.x = sign(velocity.x);
	life -= delta;
	if (life <= 0):
		queue_free();
		spawn_splash();

func _on_BaseProjectile_body_entered(body):
	if (body == source): return;
	if (body.has_method("damage")):
		body.damage(self);
	spawn_splash();
	self.queue_free();

func spawn_splash():
	var splash = splash_scene.instance();
	splash.position = self.position;
	get_parent().add_child(splash);