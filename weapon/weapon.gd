extends Node

class_name Weapon

var time_cost = 0.1

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func shoot(target_pos: Vector2):
	TimeDilation.time_scale = 1
	TimeDilation.dilation_time += time_cost
	onShoot(target_pos)

func onShoot(_target_pos):
	pass
