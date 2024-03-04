extends Node2D
class_name EnemyWeapon

var shooting = false
func shoot():
	pass

func _process(delta):
	onProcess(delta)
	onDilatedProcess(delta * TimeDilation.time_scale)
	pass

func onDilatedProcess(_delta: float):
	pass

func onProcess(_delta: float):
	pass

func onDie():
	pass
