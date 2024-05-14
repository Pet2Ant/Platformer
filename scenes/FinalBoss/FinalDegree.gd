extends Node2D
@onready var animation_player = $AnimationPlayer

func ready():
	animation_player.play("idle")

func _on_area_2d_body_entered(body):
	if (body.name == "MainAvatar"):
		body.can_control = false
		animation_player.play("DegreeGet")
		await animation_player.animation_finished
		animation_player.play("AcadProb")
		await animation_player.animation_finished
		animation_player.play("GameOver")
		await animation_player.animation_finished
		queue_free()
		body.take_damage(10)
		
