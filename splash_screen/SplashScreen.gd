extends Node2D

var _timer = Timer.new()

func _ready():
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_set_timer()

func _set_timer():
	_timer.set_wait_time(3)
	_timer.set_one_shot(true)
	_timer.start()

func _on_Timer_timeout():
	queue_free()
	var root = get_tree().get_root()
	# Add the next level
	var next_scene_resource = load("res://godot_scene/godot.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)
