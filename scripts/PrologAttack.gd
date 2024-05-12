extends Node2D


@onready var sprite_2d = get_node("Hitbox/Attack")
var speed = 300
var current_speed = 0.0
var lifetime = 4.0
var hit = false
func _physics_process(delta):
	position.y += current_speed*delta

	
	

func fall():
	current_speed = speed
	await get_tree().create_timer(lifetime).timeout
	die()
	current_speed = 0 
	
func die():
	
	sprite_2d.animation = 'explosion'
	queue_free()
	
func _on_hitbox_area_entered(area):
	print("Collided with ", area.name, " which is a ", area.get_class())
	if area.get_parent() is Player:
		print("player is hit ")
		hit = false
		speed = 0
	else:
		hit = true
		speed =0 
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(1)
		
		
	
	
	






func _on_hitbox_body_entered(body):
		current_speed = 0
		die()


