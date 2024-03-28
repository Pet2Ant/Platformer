extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -600.0

const COYOTE_TIME = 0.1
var coyote_timer = 0.0

var applied_impulse = false
var applied_impulse_timer = 0
var applied_impulse_force = 5

var force_timer = 0.0
var force_duration = 0.5  # The duration for which the force is applied

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D


func _physics_process(delta):
	#Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = 'running'
	else : 
		sprite_2d.animation = 'default'
		
	# Add impulse force to the kinematic body
	
	if applied_impulse:
		applied_impulse_timer += delta # count the time passed from t0=0
		velocity.y = -applied_impulse_force*SPEED + gravity * applied_impulse_timer # calcualte y velocity
		# if velocity ~ 0, stop applying forceaaaaaa
		if velocity.y < 0.01:
			applied_impulse_timer = 0
			applied_impulse = false
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		coyote_timer += delta
	else:
		coyote_timer = 0.0
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and coyote_timer < COYOTE_TIME:
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		
		
		# Flip the sprite based on the direction of movement.
		sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, 10)
		

	move_and_slide()
	
func add_force(explosion_position : Vector2):
	applied_impulse = true
	
	#gwnia p th kinithoume 
	print("Global position: ",global_position)
	print("Explosion position: ",explosion_position)
	var direction = (global_position - explosion_position)
	print(direction)
	
	velocity.x = direction.x * SPEED/5
	velocity.y = SPEED*direction.y/5
	

	
	
