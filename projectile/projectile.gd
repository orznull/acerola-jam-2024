extends CharacterBody2D

class_name Projectile

func init(_player: Player, _init_pos: Vector2, _target_pos: Vector2):
	pass

func _process(delta: float):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		onCollide(collision_info)

func onCollide(_collision_info: KinematicCollision2D):
	pass
