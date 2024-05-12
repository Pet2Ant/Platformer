extends Node2D

@onready var spawn_pos = global_position

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		
		if (area.get_parent().health >= 3):
			area.get_parent().health += 0
		else:
			area.get_parent().health += 1
		area.get_parent().get_node("Healthbar2").update_healthbar(area.get_parent().health, area.get_parent().max_health)
		queue_free()



