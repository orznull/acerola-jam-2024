extends Projectile

const SPEED = 600

func init(player: Player, init_pos: Vector2, target_pos: Vector2):
	position = init_pos
	velocity = (target_pos - init_pos).normalized() * SPEED
