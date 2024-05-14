extends CharacterBody2D

@onready var player = owner.find_child("MainAvatar")
@onready var animated_sprite = $AnimatedSprite2D

var direction : Vector2

func _ready():
	set_physics_process(false)

func _process(_delta):
	direction = player.position - position
	
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
func _physics_process(delta):
	print("dire",direction)
	velocity = direction.normalized()*40
	print("velo",velocity)
	move_and_collide(velocity*delta)
