extends Projectile

@export var TIME_ALIVE = 25

@export var SPEED = 2000

func init(init_pos: Vector2, target_pos: Vector2):
	position = init_pos
	velocity = (target_pos - init_pos).normalized() * SPEED
	rotation = velocity.angle()

func onProcess(delta):
	TIME_ALIVE -= delta
	if TIME_ALIVE <= 0:
		queue_free()

func onCollide(collision_info: KinematicCollision2D):
	pass
