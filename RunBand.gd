extends Node2D

const ARROW = preload("res://bullets/Arrow.tscn")
const BABY = preload("res://bullets/Baby.tscn")
const CLOTH = preload("res://bullets/Cloth.tscn")
const HEART = preload("res://bullets/Heart.tscn")
const IBO = preload("res://bullets/Ibo.tscn")
const SHOE = preload("res://bullets/Shoe.tscn")
const SISHA = preload("res://bullets/Sisha.tscn")
const STAR = preload("res://bullets/Star.tscn")
const SUGAR = preload("res://bullets/Sugar.tscn")

const FLOWER = preload("res://ground_blocks/Flower.tscn")
const SHIT = preload("res://ground_blocks/Shit.tscn")
const STONE = preload("res://ground_blocks/Stone.tscn")



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
	var some_random = int(rng.randf_range(1, 13))
	var particul = null
	match some_random:
		1:
			particul = ARROW.instance()
			particul.position = $Position2DHead.global_position
		2:
			particul = BABY.instance()
			particul.position = $Position2DAir.global_position
		3:
			particul = CLOTH.instance()
			particul.position = $Position2DHead.global_position
		4:
			particul = HEART.instance()
			particul.position = $Position2DWomans.global_position
		5:
			particul = IBO.instance()
			particul.position = $Position2DAir2.global_position
		6:
			particul = SHOE.instance()
			particul.position = $Position2DHead.global_position
		7:
			particul = SISHA.instance()
			particul.position = $Position2DHead.global_position
		8:
			particul = STAR.instance()
			particul.position = $Position2DAir2.global_position
		9:
			particul = SUGAR.instance()
			particul.position = $Position2DHead.global_position
		10:
			particul = FLOWER.instance()
			particul.position = $Position2DGround.global_position
		11:
			particul = SHIT.instance()
			particul.position = $Position2DGround.global_position
		12:
			particul = STONE.instance()
			particul.position = $Position2DGround.global_position
	
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
