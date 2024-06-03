extends CharacterBody2D

const SPEED = 100.0
@export var health: int = 20
var current_direction = "none"
var dmg = 0


var enemy_in_attack_range = false
var enemy_attack_coldown = true
var player_alive = true



func _physics_process(delta):
	player_movement(delta)
	takeDamage(dmg)
	handleCollision()
	
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

func handleCollision():
	for collision_count in get_slide_collision_count():
		var collision = get_slide_collision(collision_count)
		var collider = collision.get_collider()
		#print_debug(collider.name)

func takeDamage(damage: int):
	if enemy_attack_coldown == true and enemy_in_attack_range == true:
		health = health - damage
		enemy_attack_coldown = false
		$attack_coldown.start()
		print(health)
	if health <= 0:
		player_alive = false
		print("You are died!!")
		health = 0


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

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true
		dmg = body.damage


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
		
func player():
	pass

func _on_attack_coldown_timeout():
	enemy_attack_coldown = true
