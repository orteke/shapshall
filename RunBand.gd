extends Node2D

const AIRPARTICULES = preload("res://AirParticules.tscn")
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
	_timer.set_wait_time(rng.randf_range(1, 7))
	_timer.set_one_shot(true)
	_timer.start()
	
func _on_Timer_timeout():
	var air_particules = AIRPARTICULES.instance()
	get_parent().add_child(air_particules)
	air_particules.position = $Position2DParticules.global_position
	_set_timer()