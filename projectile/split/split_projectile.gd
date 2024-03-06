extends Projectile
const projectile = preload ("res://projectile/split/split_basic.tscn")

@export var SPEED = 2000
@export var DAMAGE = 10

@export var OFFSET = 15

var target = null
var dir = null

func init(init_pos: Vector2, target_pos: Vector2):
	target = target_pos
	dir = (target_pos - init_pos).normalized()

	position = init_pos
	velocity = dir * SPEED
	target = target_pos
	rotation = velocity.angle()

func onCollide(collision_info: KinematicCollision2D):
	var collider = collision_info.get_collider()
	if collider.has_method("damage"):
		collider.damage(DAMAGE)
	queue_free()

func onProcess(_delta):
	if target == null:
		return
	if position.distance_to(target) < 5:
		queue_free()
		var proj1 = projectile.instantiate()
		var proj2 = projectile.instantiate()
		
		get_tree().root.add_child(proj1)
		get_tree().root.add_child(proj2)
		
		proj1.init(position + dir.rotated(PI / 2) * OFFSET, position + dir.rotated(PI / 2) * (OFFSET + 1))
		
		proj2.init(position + dir.rotated( - PI / 2) * OFFSET, position + dir.rotated( - PI / 2) * (OFFSET + 1))
