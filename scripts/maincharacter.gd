# extends CharacterBody2D

# const SPEED = 200.0
# const JUMP_VELOCITY = -600.0

# const COYOTE_TIME = 0.1
# const DEATH_TILE_ID = 1
# var coyote_timer = 0.0
# var starting_position : Vector2;
# var explosion_force = Vector2.ZERO
# var explosion_force_duration = 0.05
# var explosion_force_timer = 0.0

# # Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# @onready var sprite_2d = $Sprite2D
# func _ready():
# 	starting_position=self.position
# 	print(starting_position)

# func _physics_process(delta):
# 	# Animations
# 	if (velocity.x > 1 || velocity.x < -1):
# 		sprite_2d.animation = 'running'
# 	else:
# 		sprite_2d.animation = 'default'

# 	# Add the gravity.
# 	if not is_on_floor():
# 		velocity.y += gravity * delta
# 		coyote_timer += delta
# 	else:
# 		coyote_timer = 0.0

# 	# Handle jump.
# 	if Input.is_action_just_pressed("ui_accept") and coyote_timer < COYOTE_TIME:
# 		velocity.y = JUMP_VELOCITY

# 	var direction = Input.get_axis("Left", "Right")
# 	if direction:
# 		velocity.x = direction * SPEED
# 		# Flip the sprite based on the direction of movement.
# 		sprite_2d.flip_h = direction < 0
# 	else:
# 		velocity.x = move_toward(velocity.x, 0, 10)

# 	# Apply the explosion force
# 	if explosion_force_timer < explosion_force_duration:
# 		velocity += explosion_force * delta
# 		explosion_force_timer += delta
# 	else:
# 		explosion_force = Vector2.ZERO
# 	# # Collision detection upon death 
# 	# var collision = move_and_collide(velocity*delta)
# 	# if collision:
# 	# 	var collider_position = global_position 
# 	# 	if is_on_death_tile(collider_position):
# 	# 		respawn()
# 	# move_and_slide()

# func add_force(explosion_position : Vector2):
# 	var direction = (global_position - explosion_position).normalized()
# 	explosion_force = direction* SPEED * 100
# 	explosion_force_timer = 0.0

# # func is_on_death_tile(collision_position):
# # 	var tilemap_node =  get_node("../TileMap")
# # 	if not tilemap_node:
# # 		push_error("TileMap node not found")
# # 		return false
# # 	var tile_position = tilemap_node.local_to_map(collision_position)
# # 	var tile_id =  tilemap_node.get_cellv(tile_position)
# # 	return tile_id == DEATH_TILE_ID

# # func respawn():
# # 	position = starting_position
# # 	explosion_force = Vector2.ZERO
# # 	velocity =  Vector2.ZERO
# # 	explosion_force_timer = 0.0
class_name Player
extends CharacterBody2D


@export var SPEED : float = 260
@export var JUMP_VELOCITY : float = -600.0
@export var jump_time : float = 0.25
@export var COYOTE_TIME = 0.075
@export var gravity_multiplying: float = 1.5
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumping : bool = false
var coyote_timer : float = 0.0
var jump_timer : float = 0.0
var applied_impulse = false
var applied_impulse_timer = 0
var applied_impulse_force = 5
var can_control : bool = true
var force_timer = 0.0
var force_duration = 0.5  
@onready var sprite_2d = $AnimatedSprite2D

func _ready():
	GameManager.player = self

func _physics_process(delta):
	if not can_control: return 
	#gravity 
	if not is_on_floor() and not is_jumping:
		velocity.y += gravity * gravity_multiplying* delta
		coyote_timer += delta
	else:
		coyote_timer = 0.0
	
	  

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and (is_on_floor() or coyote_timer < COYOTE_TIME) :
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif  Input.is_action_just_pressed("ui_accept") and is_jumping:
		velocity.y = JUMP_VELOCITY

	if is_jumping and Input.is_action_just_pressed("ui_accept") and jump_timer <jump_time :
		jump_timer += delta
	else:
		is_jumping  = false
		jump_timer = 0

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED

	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = 'walking'
	else : 
		sprite_2d.animation = 'default'
		
	# Add impulse force to the kinematic body
	
	if applied_impulse:
		applied_impulse_timer += delta # count the time passed from t0=0
		velocity.y = -applied_impulse_force* SPEED + gravity * applied_impulse_timer # calcualte y velocity
		# if velocity ~ 0, stop applying forceaaaaaa
		if velocity.y < 0.01:
			applied_impulse_timer = 0
			applied_impulse = false
		# Flip the sprite based on the direction of movement.
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
	
	if direction != 0:
		sprite_2d.flip_h = direction < 0
		
	move_and_slide()
	if position.y >= 600:
		die()
func add_force(explosion_position : Vector2):
	applied_impulse = true
	
	#gwnia p th kinithoume 
	print("Global position: ",global_position)
	print("Explosion position: ",explosion_position)
	var direction = (global_position - explosion_position)
	print(direction)
	
	velocity.x = direction.x * SPEED/5
	velocity.y = SPEED*direction.y/5
	
func handle_danger() -> void:
	print("Player died")
	visible = false
	can_control = false
	var lvl = LevelManager.loaded_level.level_id
	LevelManager.unload_level()
	LevelManager.load_level(lvl)
	await get_tree().create_timer(1).timeout
	reset_player()
func reset_player() -> void:
	global_position = LevelManager.loaded_level.level_start_pos.global_position
	visible = true
	can_control = true
	
func die():
	GameManager.respawn_player()
