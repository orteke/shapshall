extends KinematicBody2D

var motion = Vector2(0,0)
var animation_name = "run"

const SPEED = 60
const GRAVITY = 8
const SKIP_POWER = -150
const UP = Vector2(0, -1)

func _ready():
	run()

func _physics_process(delta):	
	if is_on_floor():
		motion.y = 0
		if Input.is_action_pressed("touched") and ($Animation.get_global_position().y-50 > get_viewport().get_mouse_position().y):
			jump()
			motion.y = SKIP_POWER
		elif Input.is_action_pressed("touched"):
			if int($Animation.get_global_position().x) == int(get_viewport().get_mouse_position().x):
				run()
				motion.x = 0
			elif $Animation.get_global_position().x < get_viewport().get_mouse_position().x:
				run_right()
				motion.x = SPEED
			elif $Animation.get_global_position().x > get_viewport().get_mouse_position().x:
				run_left()
				motion.x = -SPEED
			else:
				run()
				motion.x = 0
		elif Input.is_action_just_released("touched"):
			run()
			motion.x = 0
		else:
			run()
			motion.x = 0
	else:
		motion.y += GRAVITY 
		
	
	move_and_slide(motion, UP) 
	
func run():
	if animation_name != "run":
		$JumpAudioStreamPlayer2D.stop()	
		$Animation.play("run", false)
		
	animation_name = "run"
	
	$CollisionRun.disabled = false
	$CollisionJump.disabled = true
	$CollisionRunLeft.disabled = true
	$CollisionRunRight.disabled = true
	
func run_left():
	if animation_name != "run_left":
		$JumpAudioStreamPlayer2D.stop()	
		$Animation.play("run_left", false)
		
	animation_name = "run_left"
	
	$CollisionRun.disabled = true
	$CollisionJump.disabled = true
	$CollisionRunLeft.disabled = false
	$CollisionRunRight.disabled = true
	
func run_right():
	if animation_name != "run_right":
		$JumpAudioStreamPlayer2D.stop()	
		$Animation.play("run_right", false)
		
	animation_name = "run_right"
	
	$CollisionRun.disabled = true
	$CollisionJump.disabled = true
	$CollisionRunLeft.disabled = true
	$CollisionRunRight.disabled = false
	
func jump():
	if animation_name != "jump":
		$JumpAudioStreamPlayer2D.play()
		$Animation.play("jump", false)
		
	animation_name = "jump"
	
	$CollisionRun.disabled = true
	$CollisionJump.disabled = false
	$CollisionRunLeft.disabled = true
	$CollisionRunRight.disabled = true
