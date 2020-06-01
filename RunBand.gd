extends Node2D

const Bottle = preload("res://bottle/Bottle.tscn")
const FireHydrant = preload("res://fire_hydrant/FireHydrant.tscn")
const Heart = preload("res://heart/Heart.tscn")
const Meteor = preload("res://meteor/Meteor.tscn")

var rng = RandomNumberGenerator.new()
var _timer = Timer.new()

func _ready():	
	add_child(_timer)
	_timer.connect("timeout", self, "_on_Timer_timeout")
	_set_timer()
	rng.randomize()
	
	$CanvasLayer/ScoreControl.score.last = 0
	
func _physics_process(delta):
	$CanvasLayer/ScoreControl/Display.text = "Last: " + str($CanvasLayer/ScoreControl.score.last) + "\nBest: " + str($CanvasLayer/ScoreControl.score.best)
	
func _set_timer():
	_timer.set_wait_time(rng.randf_range(0.75, 2))
	_timer.set_one_shot(true)
	_timer.start()
	
func _on_Timer_timeout():
	var some_random = int(rng.randf_range(1, 16))
	var particul = null
	match some_random:
		1,3,5,7:
			particul = Bottle.instance()
			particul.position = $BottlePosition2D.global_position
			$CanvasLayer/ScoreControl.score.last += 10
		2,4,6,8:
			particul = FireHydrant.instance()
			particul.position = $FireHydrantPosition2D.global_position
			$CanvasLayer/ScoreControl.score.last += 25
		9,11:
			particul = Heart.instance()
			particul.position = $HeartPosition2D.global_position
			$CanvasLayer/ScoreControl.score.last += 10
		13,14,15:
			particul = Meteor.instance()
			particul.position = $MeteorPosition2D.global_position
			$CanvasLayer/ScoreControl.score.last += 5
		10:
			particul = Meteor.instance()
			particul.position = $MeteorPosition2D_2.global_position
			$CanvasLayer/ScoreControl.score.last += 5
		12:
			particul = Meteor.instance()
			particul.position = $MeteorPosition2D_3.global_position
			$CanvasLayer/ScoreControl.score.last += 5
	
	get_parent().add_child(particul)
	_set_timer()

func _womans_on_Area2D_body_entered(body):
	if body.get_name() != "Player":
		return

	queue_free()
	var root = get_tree().get_root()
	# Add the next level
	var next_scene_resource = load("res://womans_fail/WomansFail.tscn")
	var next_scene = next_scene_resource.instance()
	root.add_child(next_scene)


func _on_RunBand_tree_exiting():
	# score
	if $CanvasLayer/ScoreControl.score.best < $CanvasLayer/ScoreControl.score.last:
		$CanvasLayer/ScoreControl.score.best = $CanvasLayer/ScoreControl.score.last
		
	var score_file = File.new()
	score_file.open('user://score.json', File.WRITE)
	score_file.store_line(to_json($CanvasLayer/ScoreControl.score))

	# Close file.
	score_file.close()
	
	var root = get_tree().get_root()
	for child in root.get_children():
		if child.get_name() == "WomansFail" || child.get_name() == "Fail":
			continue
		child.queue_free()

func _on_RunBand_tree_exited():
	queue_free()
