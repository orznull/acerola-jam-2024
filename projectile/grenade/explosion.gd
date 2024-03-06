extends Area2D

const DAMAGE = 15
@onready var init_size = scale

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalPlayer.camera.shake(0.5)
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.has_method("damage"):
			b.damage(DAMAGE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta *= TimeDilation.time_scale
	if modulate.a <= 0:
		queue_free()
	
	modulate.a -= delta
	scale = lerp(scale, init_size * 1.2, 0.3 * delta)