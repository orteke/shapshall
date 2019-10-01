extends Node2D

const SUGAR = preload("res://Sugar.tscn")
const SISHA = preload("res://Sisha.tscn")
const STONE = preload("res://Stone.tscn")
const SHIT = preload("res://Shit.tscn")
const KURD = preload("res://Kurd.tscn")

var rng = RandomNumberGenerator.new()
var _timer = Timer.new()
var particules = []

func _ready():
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_set_timer()
	rng.randomize()

func _physics_process(delta):
	pass
	
func _set_timer():
	_timer.set_wait_time(rng.randf_range(1.5, 6))
	_timer.set_one_shot(true)
	_timer.start()
	
func _on_Timer_timeout():
	var some_random = int(rng.randf_range(1, 6))
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
	
	get_parent().add_child(particul)
	particules.append(particul)
	_set_timer()

func _on_RunBand_tree_exited():
	# clear all instances
	for particul in particules:
		if particul == null:
			continue
		particul.queue_free()
	queue_free()
