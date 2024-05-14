extends CharacterBody2D

@onready var player = owner.find_child("MainAvatar")
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar
var direction : Vector2
var health:= 10:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
func _ready():
	set_physics_process(false)
	

func _process(_delta):
	
	direction = player.position - position
	print("player", player)
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
func _physics_process(delta):
	velocity = direction.normalized()*120
	move_and_collide(velocity*delta)
func take_damage(damage):
	health -= damage
