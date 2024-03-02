extends CharacterBody2D
class_name Enemy

var health = 100.0

func _process(delta):
	onProcess(delta)
	onDilatedProcess(delta * TimeDilation.time_scale)

func onDilatedProcess(_delta: float):
	pass

func onProcess(_delta: float):
	pass

func damage(dmg: int):
	health -= dmg
	onDamage(dmg)
	if (health <= 0):
		for i in get_children():
			if i.has_method("onDie"):
				i.onDie()
		onDie()

func onDamage(_dmg: int):
	pass

func onDie():
	pass
