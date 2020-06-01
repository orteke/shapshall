extends Node2D

var is_clicked = false
	
func _on_TextureButton_pressed():
	if !is_clicked:
		is_clicked = true
		queue_free()
		var root = get_tree().get_root()
		# Add the next level
		var next_scene_resource = load("res://RunBand.tscn")
		var next_scene = next_scene_resource.instance()
		root.add_child(next_scene)
