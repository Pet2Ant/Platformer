extends Node2D


var direction = Vector2(0,-100)
var speed = 300
var current_speed = 0.0
var lifetime = 4.0
var hit = false
@onready var spawn_pos = global_position 
func _physics_process(delta):
	position.y += current_speed*delta
func _ready():
	fall()
	
	

func fall():
	current_speed = speed
	await get_tree().create_timer(lifetime).timeout
	position = spawn_pos
	current_speed = 0 

func _on_hitbox_area_entered(area):
	print(area.get_parent().is_in_group("Enemies"))
	if area.get_parent() is Player:
		print("player is hit ")
		hit = false
		speed = 0
	else:
		hit = true
		speed =0 
	if area.get_parent() is Player && !hit:
		area.get_parent().die()
		explode(area)
	
	
func explode(area):
	if area.get_parent():
		$AnimationPlayer.play("upon_impact")
