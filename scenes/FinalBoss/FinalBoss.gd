extends CharacterBody2D
class_name Boss
@onready var player = get_parent().find_child("MainAvatar")
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar = $UI/ProgressBar
@onready var attack = $Hit/HitCollision
var direction : Vector2
var health:= 3:
	set(value):
		health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")
func _ready():
	$AudioStreamPlayer.play()
	set_physics_process(false)
	

func _process(_delta):
	direction = player.position - position
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
func _physics_process(delta):
	if health >= 13:
		velocity = direction.normalized()*240
	elif health >= 5:
		velocity = direction.normalized()*270
	else:
		velocity = direction.normalized()*360
	move_and_collide(velocity*delta)
func take_damage(damage):
	health -= damage
