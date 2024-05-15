extends CharacterBody2D
@onready var main_scene = get_parent()
@onready var scene = main_scene.find_child("2DScene")
@onready var boss_room = scene.get_child(0)
@onready var player = boss_room.find_child("MainAvatar")
#@onready var boss = boss_room.find_child("Final boss")
@onready var animation = $AnimatedSprite2D

func ready():
	set_physics_process(false)
	await animation.animation_finished
	set_physics_process(true)
	animation.play("Idle")
	
func _physics_process(delta):
	if player.can_control:
		var direction = player.position - position
		velocity = direction.normalized() * 90
	else:
		queue_free()
	move_and_slide()

func take_damage(dmg):
	queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
			area.get_parent().take_damage(1)
			queue_free()





