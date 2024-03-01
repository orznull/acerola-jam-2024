extends CharacterBody2D

class_name Player

const RUN_SPEED = 300.0
const DECELERATION = 300.0
const WALKING_MULTIPLIER = 0.3

var prev_rotation = rotation
var angular_velocity = 0

func _ready():
	GlobalPlayer.player = self

func _physics_process(delta: float):
	
	process_velocity(delta)
	process_aim(delta)
	process_time_adjustment(delta)

	move_and_slide()

func process_velocity(_delta: float):

	var speed_adjustment = 1
	if Input.is_action_pressed("walk"):
		speed_adjustment = WALKING_MULTIPLIER

	var x_dir = Input.get_axis("move_left", "move_right")
	if x_dir:
		velocity.x = x_dir * RUN_SPEED * speed_adjustment
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	
	var y_dir = Input.get_axis("move_up", "move_down")
	if y_dir:
		velocity.y = y_dir * RUN_SPEED * speed_adjustment
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)

func process_aim(delta: float):
	var mouse_pos = get_global_mouse_position()
	prev_rotation = float(rotation)
	rotation = position.angle_to_point(mouse_pos)

	var angle_diff = fposmod(rotation - prev_rotation, TAU)
	if angle_diff > PI:
		angle_diff -= TAU
	angular_velocity = abs(angle_diff) / delta

	if Input.is_action_just_pressed("shoot"):
		var weapons = $Weapons.get_children()
		if len(weapons) > 0 and weapons[0] is Weapon:
			weapons[0].shoot(mouse_pos)

func process_time_adjustment(_delta: float):
	var adjusted_time_scale = max(velocity.length() / RUN_SPEED, min(angular_velocity / TAU, 1))
	TimeDilation.bump_time_scale(adjusted_time_scale)