extends Weapon

const projectile = preload("res://projectile/basic/basic_projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func shoot(player: Player, target_pos: Vector2):
	var bullet: Projectile = projectile.instantiate()
	get_tree().root.add_child(bullet)
	bullet.init(player, player.position, target_pos)
	
