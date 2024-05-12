extends Node
signal gained_coins(int)

var current_checkpoint : Checkpoint
var pause_menu
var win_screen
var coin_label
var score_label
var player : Player 
var points = 0
var coins = 0
var score : int = 0
var starting_pos = Vector2(180,200)

var paused = false

func add_point() :
	points += 1
	print("Points: ", points);
func remove_points() -> void :
	coins = 0
	return
	
func remove_score() -> void : 
	score = 0
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

func win():
	win_screen.visible = true
	set_process_input(false)  
	get_tree().paused = true
	score_label.text = "Score: " + str(score)
	
func pause_play():
	paused = !paused
	pause_menu.visible = paused

	
func resume():
	get_tree().paused = false
	pause_play()
	
func restart():
	get_tree().reload_current_scene()
	remove_points()
	remove_score()
	get_tree().paused = false
	current_checkpoint = null
	
func load_world():
	get_tree().change_scene_to_file("res://scenes/Scenes/world_map.tscn")

func quit():
	get_tree().quit()
