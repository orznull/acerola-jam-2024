extends CharacterBody2D

class_name Projectile

func init(player: Player, init_pos: Vector2, target_pos: Vector2):
	pass

func _process(delta: float):
	move_and_slide()
