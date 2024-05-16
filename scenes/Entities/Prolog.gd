extends CharacterBody2D

var prolog_attack = load("res://scenes/Interactables/prolog_attack.tscn")
var speed = -60.0
@export var shooting : bool
var firerate = 2
var max_health = 3
var health
var target: Node
var facing_right = true;
var dead = false;
var original_position ;
var drop_speed = 400;
var attack_mode = false;
var should_rise = false;
var bump_speed = 200;
var is_bumped = false;
@onready var floor_detector = $Hitbox/FloorCollider
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	add_to_group("Enemies")
	$AnimationPlayer.play("Flying")
	health = max_health
	shooting = true
	original_position = position
	shoot()
	
	
	

func _physics_process(delta):
	if !$RayCast2D.is_colliding():
		flip()
		
	elif $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider is Player and not attack_mode:
			attack_mode = true
			velocity.y = drop_speed
	velocity.x = speed 
	if should_rise:
		rise_up(delta)
	move_and_slide()

	
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x)*-1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed)*-1
func _on_floor_detect_body_entered(body):
	if not body is Player:
		should_rise = true
func rise_up(delta):
	if position.y > original_position.y:
		velocity.y = -drop_speed
	else:
		position.y = original_position.y  # Snap back to the original altitude.
		velocity.y = 0  
		should_rise = false  # No longer need to rise up.
		attack_mode = false
	move_and_slide()
func die():
	if not dead:
		dead = true
		speed = 0
		GameManager.gain_score(100)
		$AnimationPlayer.play("Die")
		await get_tree().create_timer(0.5).timeout
		queue_free()

func shoot():
	var spawned_attack = prolog_attack.instantiate()
	spawned_attack.position = Vector2(0,42)
	add_child(spawned_attack)
	spawned_attack.fall()
	
	
func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead:
		area.get_parent().take_damage(1)
func take_damage(damage_amount):
	print("im taking damage")
	if !dead:
		health -= damage_amount
		find_child("Healthbar").update_healthbar(health, max_health)
		$AnimationPlayer.play("OnHit")
		await get_tree().create_timer(0.5).timeout
		$AnimationPlayer.play("Flying")
		if health <= 0:
			die()




