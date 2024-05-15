extends State

var can_transition: bool =  false

func enter():
	super.enter()
	animation_player.play("skill")
	await animation_player.animation_finished
	
	
func teleport():
	can_transition = true
	owner.position = player.position + Vector2.RIGHT * 50 + Vector2.UP * 10

func transition():
	if can_transition:
		get_parent().change_state("Attack")
		can_transition = false
		
