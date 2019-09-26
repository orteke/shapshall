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
	_timer.set_wait_time(rng.randf_range(1.5, 6))
	_timer.set_one_shot(true)
	_timer.start()
	
func _on_Timer_timeout():
	var some_random = int(rng.randf_range(1, 6))
	match some_random:
		1:
			var particul = SUGAR.instance()
			get_parent().add_child(particul)
			particul.position = $Position2DHead.global_position
		2:
			var particul = SISHA.instance()
			get_parent().add_child(particul)
			particul.position = $Position2DHead.global_position
		3:
			var particul = STONE.instance()
			get_parent().add_child(particul)
			particul.position = $Position2DGround.global_position
		4:
			var particul = SHIT.instance()
			get_parent().add_child(particul)
			particul.position = $Position2DGround.global_position
		5:
			var particul = KURD.instance()
			get_parent().add_child(particul)
			particul.position = $Position2DAir.global_position
		
	_set_timer()