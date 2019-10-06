extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func parse_input_event (event):
	print(event)

func _on_TextureButton_pressed():
	queue_free()
	var root = get_tree().get_root()
	# Add the next level
	var next_scene_resource = load("res://RunBand.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)