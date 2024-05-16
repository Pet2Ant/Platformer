extends Node2D

var got_coin = false
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if got_coin == false :
			GameManager.gain_coins(1)
			GameManager.gain_score(50)
		die()
		
func die():
	got_coin = true 
	$AudioStreamPlayer.play()
	await get_tree().create_timer(0.2).timeout
	queue_free()
