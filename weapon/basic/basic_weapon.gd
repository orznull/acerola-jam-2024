extends Weapon
const projectile = preload ("res://projectile/basic/basic_projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Crosshair.global_position = get_global_mouse_position()
	# $AimLine.set_point_position(0, offset)
	# $AimLine.set_point_position(1, $Crosshair.position)
	pass

func onShoot(target_pos: Vector2):
	var bullet: Projectile = projectile.instantiate()
	get_tree().root.add_child(bullet)
	bullet.init(global_position, target_pos)
