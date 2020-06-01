extends Node2D

var is_new_game_lock = true
var score = {}

func _ready():
	$AnimatedSprite.play("fail")

func _physics_process(delta):	
	if Input.is_action_just_released("touched") and !is_new_game_lock:
		queue_free()
		var root = get_tree().get_root()
		# Add the next level
		var next_scene_resource = load("res://RunBand.tscn")
		var next_scene = next_scene_resource.instance()
		root.add_child(next_scene)
	elif Input.is_action_just_released("touched"):
		is_new_game_lock=false
