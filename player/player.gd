extends CharacterBody2D

class_name Player

const SPEED = 300.0
const DECELERATION = 300.0

func _physics_process(delta: float):
	process_velocity(delta)
	process_aim(delta)
	move_and_slide()

func process_velocity(_delta: float):
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

func process_aim(_delta: float):
	var mouse_pos = get_global_mouse_position()
	rotation = position.angle_to_point(mouse_pos)
	if Input.is_action_just_pressed("shoot"):
		var weapons = $Weapons.get_children()
		if len(weapons) > 0 and weapons[0] is Weapon:
			weapons[0].shoot(self, mouse_pos)
