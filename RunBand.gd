extends Node2D

const SUGAR = preload("res://Sugar.tscn")
const SISHA = preload("res://Sisha.tscn")
const STONE = preload("res://Stone.tscn")
const SHIT = preload("res://Shit.tscn")
const KURD = preload("res://Kurd.tscn")

var rng = RandomNumberGenerator.new()
var _timer = Timer.new()

func _ready():
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_set_timer()
	rng.randomize()

func _physics_process(delta):
	pass
	
func _set_timer():
	_timer.set_wait_time(rng.randf_range(1.5, 4))
	_timer.set_one_shot(true)
	_timer.start()
	
func _on_Timer_timeout():
	var some_random = int(rng.randf_range(1, 7))
	var particul = null
	match some_random:
		1:
			particul = SUGAR.instance()
			particul.position = $Position2DHead.global_position
		2:
			particul = SISHA.instance()
			particul.position = $Position2DHead.global_position
		3:
			particul = STONE.instance()
			particul.position = $Position2DGround.global_position
		4:
			particul = SHIT.instance()
			particul.position = $Position2DGround.global_position
		5:
			particul = KURD.instance()
			particul.position = $Position2DAir.global_position
		6:
			particul = KURD.instance()
			particul.position = $Position2DAir2.global_position
	
	get_parent().add_child(particul)
	_set_timer()
	
func _on_RunBand_tree_exiting():
	var root = get_tree().get_root()
	for child in root.get_children():
		if child.get_name() == "Node2D":
			continue
		child.queue_free()

func _on_RunBand_tree_exited():	
	queue_free()

func _on_WomansArea2D_body_entered(body):
	if body.get_name() != "Player" || body.get_name() == "womans":
		return
		
	queue_free()
	var root = get_tree().get_root()
	# Add the next level
	var next_scene_resource = load("res://Kiss.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)
