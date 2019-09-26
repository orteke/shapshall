extends KinematicBody2D

var velocity = Vector2()

const SPEED = 60
const GRAVITY = 5
const SKIP_POWER = -120
const FLOOR = Vector2(0, -1)

var time = 0
var time_mult = 1.0

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		right()
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		left()
	else:
		velocity.x = 0
		run()
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = SKIP_POWER
	
	if !is_on_floor() and velocity.y < -0.2:
		skip()
	
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
func right():
	$RightAnimatedSprite.visible = true
	$LeftAnimatedSprite.visible = false
	$WalkingAnimatedSprite.visible = false
	$SkipAnimatedSprite.visible = false
	
	$RightCollisionShape2D.disabled = false
	$LeftCollisionShape2D.disabled = true
	$WalkingCollisionShape2D.disabled = true
	$SkipCollisionShape2D.disabled = true
	
func left():
	$LeftAnimatedSprite.visible = true
	$RightAnimatedSprite.visible = false
	$WalkingAnimatedSprite.visible = false
	$SkipAnimatedSprite.visible = false
	
	$LeftCollisionShape2D.disabled = false
	$RightCollisionShape2D.disabled = true
	$WalkingCollisionShape2D.disabled = true
	$SkipCollisionShape2D.disabled = true
	
func skip():
	$SkipAnimatedSprite.visible = true
	$WalkingAnimatedSprite.visible = false
	$LeftAnimatedSprite.visible = false
	$RightAnimatedSprite.visible = false
	
	$SkipCollisionShape2D.disabled = false
	$WalkingCollisionShape2D.disabled = true
	$LeftCollisionShape2D.disabled = true
	$RightCollisionShape2D.disabled = true
	
func run():
	$WalkingAnimatedSprite.visible = true
	$LeftAnimatedSprite.visible = false
	$RightAnimatedSprite.visible = false
	$SkipAnimatedSprite.visible = false
	
	$WalkingCollisionShape2D.disabled = false
	$LeftCollisionShape2D.disabled = true
	$RightCollisionShape2D.disabled = true
	$SkipCollisionShape2D.disabled = true