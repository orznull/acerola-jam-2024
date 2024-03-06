extends Weapon

# Called when the node enters the scene tree for the first time.
func _ready():
	time_cost = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Crosshair.global_position = get_global_mouse_position()
	# $AimLine.set_point_position(0, offset)
	# $AimLine.set_point_position(1, $Crosshair.position)
	pass

func onShoot(target_pos: Vector2):
	GlobalPlayer.player.global_position = get_global_mouse_position()
	shooting = false