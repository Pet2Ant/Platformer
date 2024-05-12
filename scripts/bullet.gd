extends Area2D

const BULLET_SPEED = 300.0
const RANGE = 600
var travelled_distance = 0
const EXPLOSION_STRENGTH = 500.0 
const EXPLOSION_RADIUS = 10.0
const EXPLOSION = preload("res://scenes/Entities/explosion.tscn")


func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * BULLET_SPEED * delta
	
	travelled_distance += BULLET_SPEED * delta
	if travelled_distance > RANGE:
		explode()
		queue_free()


func _on_body_entered(body):
	if (body.name == "MainAvatar"):
		return
		
	explode()
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(1)

func explode():
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	explosion.get_node("Explosion").play()  # Start the animation
	get_tree().root.add_child(explosion)
	
	emit_signal("explosion_occurred", global_position)
	
