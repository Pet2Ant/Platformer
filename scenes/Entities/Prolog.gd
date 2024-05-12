extends CharacterBody2D

var prolog_attack = load("res://scenes/Interactables/prolog_attack.tscn")
var speed = -60.0
@export var shooting : bool
var firerate = 2
var max_health = 3
var health

var facing_right = true;
var dead = false;
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _ready():
	add_to_group("Enemies")
	$AnimationPlayer.play("Flying")
	health = max_health
	shooting = true
	shoot()
	

func _physics_process(delta):
	# remove the gravity.
	if is_on_floor():
		velocity.y += -gravity * delta
	if !$RayCast2D.is_colliding() && !is_on_floor():
		flip()
	velocity.x = speed
	move_and_slide()
func flip():
	facing_right = !facing_right
	scale.x = abs(scale.x)*-1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed)*-1


func die():
	dead = true
	speed = 0
	queue_free()

func shoot():
	var spawned_attack = prolog_attack.instantiate()
	spawned_attack.position = Vector2(0,42)
	add_child(spawned_attack)
	spawned_attack.fall()
	
	
	
func _on_hitbox_area_entered(area):
	if area.get_parent() is Player && !dead:
		area.get_parent().take_damage(1)
		area.get_parent().die()
	
