extends CharacterBody2D

var run_speed = 25
@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

@export var damage: int = 1



func _physics_process(delta):
	var anim = $AnimatedSprite2D
	if player:
		nav_agent.target_position = player.position
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		
		if dir.x > 0:
			anim.flip_h = false
			anim.play("move_side")
		else:
			anim.flip_h = true
			anim.play("move_side")
		velocity = dir * run_speed
#		velocity = position.direction_to(player.position) * run_speed
		move_and_slide()

func _on_detection_area_body_entered(body):
	player = body

func _on_detection_area_body_exited(body):
	player = null
	
func enemy():
	pass
