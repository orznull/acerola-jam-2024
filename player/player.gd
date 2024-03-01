extends CharacterBody2D


const SPEED = 300.0
const DECELERATION = 50.0

func _physics_process(delta):
	
	var x_dir = Input.get_axis("move_left", "move_right")
	
	if x_dir:
		velocity.x = x_dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	var y_dir = Input.get_axis("move_up", "move_down")
	if y_dir:
		velocity.y = y_dir * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)

	move_and_slide()
