extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	var animations = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = animations[randi() % animations.size()]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
