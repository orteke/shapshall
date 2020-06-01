extends AnimatedSprite

const ROTATION_SPEED = 0.1

func _physics_process(delta):
	# rotate object
	rotation = rotation + ROTATION_SPEED
