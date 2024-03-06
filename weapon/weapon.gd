extends Sprite2D

class_name Weapon

var time_cost = 0.1
var shooting = false

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func shoot(target_pos: Vector2):
	TimeDilation.time_scale = 1
	TimeDilation.dilation_time += time_cost
	shooting = true
	onShoot(target_pos)

func onShoot(_target_pos):
	pass
