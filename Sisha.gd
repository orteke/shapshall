extends Area2D

const SPEED = 30
const ROTATION_SPEED = 0.1
const velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

func _physics_process(delta):
	velocity.x = -(SPEED * delta)
	translate(velocity)
	
	# rotate object
	rotation = rotation + ROTATION_SPEED
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_sisha_body_entered(body):
	print(body.get_name())
	queue_free()
	if body.get_name() == "womans":
		return
	# remove main scene
	var root = get_tree().get_root()
	var scene = root.get_node("RunBand")
	root.remove_child(scene)
	scene.free()
	# Add the next level
	var next_scene_resource = load("res://Fall.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)
