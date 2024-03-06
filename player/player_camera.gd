extends Camera2D

const MAX_DISTANCE = 100

var center_pos = position

var shake_timer = 0
var shake_strength = 0

func _ready():
	GlobalPlayer.camera = self

func _process(delta):
	var mouse_pos = get_local_mouse_position()

	var target_distance = center_pos.distance_to(mouse_pos)

	var direction = center_pos.direction_to(mouse_pos)
	var target_pos = center_pos + direction * target_distance

	target_pos = target_pos.clamp(
		center_pos - Vector2(MAX_DISTANCE, MAX_DISTANCE),
		center_pos + Vector2(MAX_DISTANCE, MAX_DISTANCE),
	)

	position = lerp(position, target_pos, 0.1)

	if shake_strength > 0:
		offset = shake_strength * Vector2(randf_range( - 1, 1), randf_range( - 1, 1))
		if shake_timer >= 0:
			shake_timer -= delta
		else:
			shake_strength -= 2
	else:
		offset = Vector2.ZERO

func shake(time, strength=10):
	shake_timer += time
	shake_strength = max(shake_strength, strength)
