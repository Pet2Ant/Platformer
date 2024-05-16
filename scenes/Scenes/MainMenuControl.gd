class_name MainMenu
extends Control

func _on_play_btn_pressed():
	LevelManager.load_level(0)
	print("Level upon pressing play",LevelManager.levelId)
	deactivate()


func _on_instructions_btn_pressed():
	pass # Replace with function body.


func _on_quit_btn_pressed():
	get_tree().quit()

func deactivate () -> void:
	hide()
	set_process(false)
	set_physics_process(false)
	set_process_unhandled_input(false)
	set_process_input(false)

func reactivate () -> void:
	show()
	set_process(true)
	set_physics_process(true)
	set_process_unhandled_input(true)
	set_process_input(true)
