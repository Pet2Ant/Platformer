extends Node
signal gained_coins(int)
@onready var points_label = %PointsLabel
var current_checkpoint : Checkpoint
var player : Player 
var points = 0;
var coins = 0;
var initial_checkpoint = $CheckpointHolder.get_node("Checkpoint")

func add_point() :
	points += 1;
	print("Points: ", points);
	points_label.text = "Points: " +  str(points);
func remove_points() -> void :
	points = 0;
	return
func return_points() -> int:
	return points
func respawn_player():
	print(player.health)
	print(player.max_health)
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position
		player.SPEED = 0.0
	elif (player.health == 0 && current_checkpoint.global_position != initial_checkpoint):
		initial_checkpoint.activate()
		player.position = current_checkpoint.global_position
		
		
func gain_coins(coins_gained):
	coins += coins_gained
	emit_signal("gained_coins", coins)

