extends Node2D
class_name Level


@export var level_id : int
@export var level_start_pos : Node2D
var level_data : LevelData
func _ready():
	level_data = LevelManager.get_level_data_by_id(level_id) 
