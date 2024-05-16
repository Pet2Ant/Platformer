extends CharacterBody2D
@onready var main_scene = get_parent()
@onready var scene = main_scene.find_child("2DScene")
@onready var boss_room = scene.get_child(0)
@onready var player = boss_room.find_child("MainAvatar")
@onready var boss = boss_room.find_child("FinalBoss")
@onready var animation = $AnimatedSprite2D
var max_speed = 200
func ready():
	set_physics_process(false)
	await animation.animation_finished
	set_physics_process(true)
	animation.play("Idle")


func _physics_process(delta):
	if player.can_control: 
		var dist = player.position.distance_to(position)
		if dist > 60:
			var direction = player.position - position
			velocity = direction.normalized() * max_speed
		else:
			velocity = (player.position - position).normalized() * (max_speed / 200)
	else: 
		queue_free()
	if boss.find_child("FiniteStateMachine").get_state() == boss.find_child("FiniteStateMachine").find_child("Death"):
		queue_free()
	move_and_collide(velocity*delta)

func take_damage(dmg):
	queue_free()

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
			area.get_parent().take_damage(1)
			queue_free()





