extends Weapon
const projectile = preload ("res://projectile/basic/basic_projectile.tscn")

const BULLET_OFFSET_AMOUNT = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var mouse_pos = get_global_mouse_position()
	var perpindicular_direction = (mouse_pos - global_position).normalized().rotated(PI / 2)

	var bullet_offset = perpindicular_direction * BULLET_OFFSET_AMOUNT
	$Crosshair1.global_position = mouse_pos + bullet_offset
	$Crosshair2.global_position = mouse_pos - bullet_offset

func onShoot(target_pos: Vector2):
	var bullet: Projectile = projectile.instantiate()
	var bullet2: Projectile = projectile.instantiate()
	get_tree().root.add_child(bullet)
	get_tree().root.add_child(bullet2)

	var perpindicular_direction = (target_pos - global_position).normalized().rotated(PI / 2)

	var bullet_offset = perpindicular_direction * BULLET_OFFSET_AMOUNT

	bullet.init(global_position + bullet_offset, target_pos + bullet_offset)
	bullet2.init(global_position - bullet_offset, target_pos - bullet_offset)

	shooting = false
