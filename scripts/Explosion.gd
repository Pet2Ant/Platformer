extends AnimatedSprite2D




func _on_animation_finished():
	queue_free()


func _on_explosion_area_body_entered(body):
	if (body.name == "MainAvatar"):
		print(body)
		var facing_left = position.x < body.global_position.x
		if facing_left:
			body.add_force(global_position)
	else:
		print("Non-enemy hit: ", body.name)
		
