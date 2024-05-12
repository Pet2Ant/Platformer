extends Node
signal gained_coins(int)
@onready var points_label = %PointsLabel
var current_checkpoint : Checkpoint
var player : Player 
var points = 0;
var coins = 0;
var starting_pos = Vector2(180,200)

func add_point() :
	points += 1;
	print("Points: ", points);
	points_label.text = "Points: " +  str(points);
func remove_points() -> void :
	coins = 0;
	return
func return_points() -> int:
	return points
func respawn_player():
	if player.health == 0:
		print("????")
		current_checkpoint = starting_pos
		player.position = current_checkpoint.global_position
	elif player.health !=0 &&  current_checkpoint != null:
		print("i respawned here iguess?")
		player.position = current_checkpoint.global_position
	
		
		
func gain_coins(coins_gained):
	coins += coins_gained
	emit_signal("gained_coins", coins)

