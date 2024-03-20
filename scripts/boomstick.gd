extends Area2D

var direction = Vector2()
var cooldown = 0.8  # Cooldown time in seconds reduce for faster shooting
var timer = 0.0  # Time since last shot

func _process(delta):
	direction = get_global_mouse_position() - global_position
	rotation = direction.angle()

	timer += delta  # Increment the timer
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer >= cooldown:
		shoot()
		timer = 0.0  

func shoot():
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
