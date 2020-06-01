extends Area2D

const SPEED = 120
const velocity = Vector2()

func _physics_process(delta):
	velocity.x = -(SPEED * delta)
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.get_name() != "Player":
		return
		
	queue_free()
	
	# remove main scene
	var root = get_tree().get_root()
	var scene = root.get_node("RunBand")
	scene.queue_free()
	root.remove_child(scene)
	# Add the next level
	var next_scene_resource = load("res://fail/Fail.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)
