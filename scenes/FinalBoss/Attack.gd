extends State

func enter():
	super.enter()
	
	
func attack(move = "1"):
	animation_player.play("attack_" + move)
	await animation_player.animation_finished

func combo():
	var move_set = ["1","1","2"]
	for i in move_set:
		await attack(i)
	combo()



func transition():
	if owner.direction.length() >40 :
		get_parent().change_state("Follow")


func _on_area_2d_area_entered(area):
	get_tree().create_timer(0.6).timeout
	if area.get_parent() is Player:
		combo()
		area.get_parent().take_damage(1)
		print(area.get_parent().health)
