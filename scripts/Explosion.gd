extends AnimatedSprite2D


func _on_explosion_area_body_entered(body):
	if (body.name == "MainAvatar"):
		print(body)
		body.add_force(global_position)


func _on_animation_finished():
	queue_free()
