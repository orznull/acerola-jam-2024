extends CanvasLayer

@export var MAX_OFFSET = 10
@export var DEADZONE = 2
var max_offset_vec = Vector2(1, 1) * MAX_OFFSET

var prev_camera_position = Vector2(0, 0)

func _process(_delta):
	# some fun smoothing logic
	if not GlobalPlayer.camera:
		return
	
	var camera_velocity = (GlobalPlayer.camera.position - prev_camera_position)

	if camera_velocity.distance_to(Vector2.ZERO) > DEADZONE:
		offset = -camera_velocity.clamp(
			- max_offset_vec,
			max_offset_vec
		)
	prev_camera_position = GlobalPlayer.camera.position

	offset = lerp(offset, Vector2.ZERO, 0.3)