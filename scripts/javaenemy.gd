extends StaticBody2D


var java_fire = load("res://scenes/Interactables/java_attack.tscn")

@export var shooting : bool
var firerate = 2
var dead = false;
@onready var animation_player = $AnimationPlayer
@onready var firepoint =  $Firepoint
var max_health = 3
var health 

func _ready():
	if dead:
		return
	health = max_health
	shooting = true
	shoot()

func shoot():
	while shooting:
		$AnimationPlayer.play("Fire")
		$AudioStreamPlayer2D.play()
		await get_tree().create_timer(1.3).timeout

		
func fire():
	var spawned_ball = java_fire.instantiate()
	spawned_ball.direction = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
		
		
func take_damage(damage_amount):
	if !dead:
		health = health - damage_amount
		$AnimationPlayer.play("onhit")
		if health <= 0:
			die()
func die():
	if not dead:
		dead = true
		shooting = false
		$AnimationPlayer.play("Die")
		await get_tree().create_timer(0.5).timeout
		queue_free()
