extends Node2D

const AIRPARTICULES = preload("res://AirParticules.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_focus_next"):
		var air_particules = AIRPARTICULES.instance()
		get_parent().add_child(air_particules)
		air_particules.position = $Position2DParticules.global_position
	
	