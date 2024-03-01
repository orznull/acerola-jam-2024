extends CharacterBody2D

class_name Projectile

func init(_init_pos: Vector2, _target_pos: Vector2):
	pass

func _process(delta: float):
	delta = delta * TimeDilation.time_scale
	var collision_info = move_and_collide(velocity * delta)
	onProcess(delta)
	if collision_info:
		onCollide(collision_info)

func onProcess(_delta: float):
	pass

func onCollide(_collision_info: KinematicCollision2D):
	pass
