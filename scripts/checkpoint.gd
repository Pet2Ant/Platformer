class_name Checkpoint
extends Node2D

@export var spawnpoint = false
@export var win_condition = false

var activated = false 
func _ready():
	if spawnpoint:
		activate()
func activate():
	if win_condition:
		GameManager.win()
	GameManager.current_checkpoint = self
	activated = true
	

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !activated:
		activate()
 
