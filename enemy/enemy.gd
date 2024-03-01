extends Node
class_name Enemy

var health = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func damage(dmg: int):
	health -= dmg
	if (health <= 0):
		die()
	
func die():
	pass
