extends State
@export var degree_node: PackedScene

func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	

func boss_slained():
	get_parent().get_parent().get_parent().find_child("MainAvatar").can_take_damage = false
	animation_player.play("boss_slained")
	await animation_player.animation_finished


func spawn():
	var degree = degree_node.instantiate()
	degree.position = get_parent().get_parent().get_parent().position + Vector2(378,219)
	get_tree().current_scene.add_child(degree)
	
	
	
