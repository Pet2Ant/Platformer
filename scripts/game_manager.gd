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
var power_up_duration = 30.0
var paused = false
var playerNode : Node2D
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

func power_up(power_up,body):
	playerNode = body
	playerNode.power_up(power_up)
	var timer = Timer.new()
	timer.wait_time = power_up_duration
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout",Callable(self, "_on_Timer_timeout")) 
	timer.start()
	

func _on_Timer_timeout():
	playerNode.downgrade_power_up()


	
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
	get_tree().paused = false
	set_process_input(true)  
	var lvl = LevelManager.levelId + 1
	print("LEVEL",lvl)
	LevelManager.unload_level()
	LevelManager.load_level(lvl)
	
func quit():
	get_tree().quit()
