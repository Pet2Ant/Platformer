extends State
@export var degree_node: PackedScene

func enter():
	super.enter()
	animation_player.play("death")

func boss_slained():
	animation_player.play("boss_slained")
	spawn()

func spawn():
	var degree = degree_node.instantiate()
	degree.position = owner.position + Vector2(40,0)
	get_tree().current_scene.add_child(degree)
	
