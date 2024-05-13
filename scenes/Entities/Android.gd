extends CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var speed = -60
var normal_speed = 60.0
var max_health = 3
var health
var target: Node
var facing_right = false;
var dead = false;
var original_position;
var left_boundary;
var right_boundary;
var is_player =false
var is_player_damage = false;
func _ready():
	add_to_group("Enemies")
	$AnimatedSprite2D.play("idle")
	health = max_health
	original_position  = position
	left_boundary = original_position.x - 125
	right_boundary = original_position.x + 125
	
func _physics_process(delta):
	
	if dead:
		return 
	if !$Hitbox/CheckForGap.is_colliding():
		velocity.y = gravity *delta 
		flip()
		
			
		
	if (position.x == left_boundary || position.x == right_boundary) && !is_player:
		flip()
	elif (position.x > left_boundary || position.x < right_boundary ) && is_player:
		if is_player && !dead:
			velocity.x = velocity.x*3
			move_and_slide()
			var player_pos = target.global_position.x
			if facing_right && player_pos- position.x<0:
					flip()
					if is_player_damage:
						$AnimatedSprite2D.play("attacking")
						target.take_damage(1)
			elif !facing_right && player_pos - position.x>0:
					flip()
					if is_player_damage:
						$AnimatedSprite2D.play("attacking")
						target.take_damage(1)
			if is_player_damage:
				$AnimatedSprite2D.play("attacking")
				target.take_damage(1)
	elif (position.x == left_boundary || position.x == right_boundary) && is_player:
		var dir = original_position.x - position.x
		if dir > 0 && !facing_right:
			flip()
		elif dir < 0 && facing_right:
			flip()
	if $PlayerMonitor/CollisionCheck.is_colliding() && !is_player:
			flip()
	velocity.x = speed
	move_and_slide()


func return_to_pos():
	var dir = original_position.x - position.x
	if dir > 0 && !facing_right:
		flip()
	elif dir < 0 && facing_right:
		flip()

func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x)*-1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed)*-1


func take_damage(damage_amount):
	if !dead:
		health -= damage_amount
		if health <= 0:
			die()
func die():
	if not dead:
		dead = true
		speed = 0
		queue_free()

func _on_player_monitor_area_entered(area):
	if area.get_parent() is Player && !dead :
		target = area.get_parent()
		is_player = true 
			
		
			

func _on_player_monitor_area_exited(area):
	if area.get_parent() is Player && !dead:
		is_player = false 
		target = null
		$AnimatedSprite2D.play("idle")
		
func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead :
		is_player_damage = true 

func _on_hitbox_area_exited(area):
	if area.get_parent() is Player && !dead:
		is_player_damage = false 
		$AnimatedSprite2D.play("idle")





