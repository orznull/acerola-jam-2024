extends BasicProjectile
var EXPLOSION = preload ("res://projectile/grenade/explosion.tscn")

func onCollide(collision_info):
	var collider = collision_info.get_collider()
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = collider.global_position
	get_tree().root.add_child(explosion)
	queue_free()
