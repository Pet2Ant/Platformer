extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -600.0

const COYOTE_TIME = 0.1
var coyote_timer = 0.0

var explosion_force = Vector2.ZERO
var explosion_force_duration = 0.05
var explosion_force_timer = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
    # Animations
    if (velocity.x > 1 || velocity.x < -1):
        sprite_2d.animation = 'running'
    else:
        sprite_2d.animation = 'default'

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

    # Apply the explosion force
    if explosion_force_timer < explosion_force_duration:
        velocity += explosion_force * delta
        explosion_force_timer += delta
    else:
        explosion_force = Vector2.ZERO

    move_and_slide()

func add_force(explosion_position : Vector2):
    var direction = (global_position - explosion_position).normalized()
    explosion_force = direction* SPEED * 100
    explosion_force_timer = 0.0

