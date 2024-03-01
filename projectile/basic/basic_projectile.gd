extends Projectile

@export var SPEED = 600
@export var DAMAGE = 10

func init(_player: Player, init_pos: Vector2, target_pos: Vector2):
	position = init_pos
	velocity = (target_pos - init_pos).normalized() * SPEED

func onCollide(collision_info: KinematicCollision2D):
	var collider = collision_info.get_collider()
	if collider is Enemy:
		collider.damage(DAMAGE)
	queue_free()
