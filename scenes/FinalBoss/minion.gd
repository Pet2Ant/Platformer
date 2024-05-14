extends CharacterBody2D

@onready var player = get_parent().find_child("MainAvatar")
@onready var animation = $AnimatedSprite2D

func ready():
	set_physics_process(false)
	await animation.animation_finished
	set_physics_process(true)
	animation.play("Idle")
	
func _physics_process(delta):
	var direction = player.position - position
	velocity = direction.normalized() * 90
	move_and_slide()

func take_damage(dmg):
	queue_free()
