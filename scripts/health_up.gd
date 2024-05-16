extends Node2D

@onready var spawn_pos = global_position
var got_health = false
func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		if got_health == false:
			if (area.get_parent().health >= 3):
				area.get_parent().health += 0
			else:
				area.get_parent().health += 1
		die(area.get_parent())
func die(body):
	got_health = true
	body.get_node("Healthbar2").update_healthbar(body.health, body.max_health)
	queue_free()



