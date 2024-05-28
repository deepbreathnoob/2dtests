extends CharacterBody2D

const SPEED = 100.0
var current_direction = "none"

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		velocity.y = 0
		current_direction = "right"
		play_anim(1)
	elif  Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		velocity.y = 0
		current_direction = "left"
		play_anim(1)
	elif  Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = SPEED
		current_direction = "down"
		play_anim(1)
	elif  Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -SPEED
		current_direction = "up"
		play_anim(1)
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		current_direction = "idle"

	move_and_slide()

func play_anim(movement):
	var dir = current_direction
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("run_right")
		elif movement == 0:
			anim.play("idle_right")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("run_right")
		elif movement == 0:
			anim.play("idle_right")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("run_up")
		elif movement == 0:
			anim.play("idle_up")
	if dir == "down":
		if movement == 1:
			anim.play("run_down")
		elif movement == 0:
			anim.play("idle_down")
