extends Node2D
class_name WeaponsManager

@export var RELOAD_TIME = 1

var reloading = false
var reloading_timer = 0

var shoot_active = false

var active_weapon_index: int = 0;

func _ready():
	GlobalPlayer.weapons_manager = self

func _process(delta):
	
	if reloading:
		TimeDilation.time_scale = 1
		var empty_target_rotation = -PI / 3 if should_flip() else PI / 3
		$Empty.rotation = lerp($Empty.rotation, empty_target_rotation, 0.3)
		reloading_timer -= delta
		if reloading_timer <= 0:
			reloading = false
			reload()
			$Empty.rotation = 0

	var active_weapon = get_active_weapon()
	
	if shoot_active and active_weapon != $Empty and not active_weapon.shooting:
		switch_weapon()

	var target_rotation = global_position.angle_to_point(get_global_mouse_position())
	rotation = lerp_angle(rotation, target_rotation, 0.3)

	active_weapon.flip_v = should_flip()
		
func get_active_weapon():
	var index = 0
	var active = null
	for weapon in $WeaponsList.get_children():
		if index == active_weapon_index:
			active = weapon
			weapon.visible = true
		else:
			weapon.visible = false
		index += 1

	if active:
		$Empty.visible = false
		return active
	else:
		$Empty.visible = true
		return $Empty

func shoot(target_pos: Vector2):
	var active_weapon = get_active_weapon()
	if active_weapon.has_method("shoot"):
		active_weapon.shoot(target_pos)
		shoot_active = true
	elif not reloading:
		reloading = true
		reloading_timer = RELOAD_TIME

func switch_weapon():
	# recoil
	rotation = rotation - PI / 6 * (-1 if should_flip() else 1)
	active_weapon_index += 1
	shoot_active = false

func reload():
	
	var new_order = $WeaponsList.get_children()
	new_order.shuffle()
	for i in $WeaponsList.get_children():
		$WeaponsList.remove_child(i)
	for i in new_order:
		$WeaponsList.add_child(i)
	active_weapon_index = 0
	# reload shake
	rotation = rotation + PI / 3 * (-1 if should_flip() else 1)

func should_flip():
	# TODO: replace this idk im lazy man
	var true_angle = Vector2.RIGHT.rotated(rotation).angle_to(Vector2.RIGHT)
	return true_angle < - PI / 2 or true_angle > PI / 2
