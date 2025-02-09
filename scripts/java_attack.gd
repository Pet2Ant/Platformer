extends Node2D

var direction
var speed = 300.0
var lifetime = 2.5
var hit = false

func _ready():
	await get_tree().create_timer(lifetime).timeout
	die()
func _physics_process(delta):
	position.x += abs(speed*delta)*direction 
func die():
	hit = true
	speed = 0
	$AnimationPlayer.play("idle")
	queue_free()


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player && !hit:
		area.get_parent().take_damage(1)
		die()



func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		queue_free()
