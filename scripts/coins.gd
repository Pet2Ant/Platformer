extends Node2D


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		GameManager.gain_coins(1)
		GameManager.score += 50
		$AudioStreamPlayer.play()
		await get_tree().create_timer(0.2).timeout
		queue_free()
