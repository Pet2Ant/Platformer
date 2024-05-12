extends AnimatedSprite2D




func _on_animation_finished():
	queue_free()


func _on_explosion_area_body_entered(body):
	if (body.name == "MainAvatar"):
		print(body)
		body.add_force(global_position)
	if body.is_in_group("Enemies"):
		print("Enemy hit: ", body.name)
		body.die()
	else:
		print("Non-enemy hit: ", body.name)
		
