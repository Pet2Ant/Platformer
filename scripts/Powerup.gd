extends Area2D
@onready var game_manager = %GameManager
var power = 0.4



func _ready():
	$AnimationPlayer.play("Minijump")
func _on_body_entered(body):
	if (body.name == "MainAvatar"):
		queue_free()
		game_manager.power_up(power,body)
		
