extends Area2D

const DAMAGE = 15
@onready var init_size = scale

var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalPlayer.camera.shake(0.5)
	await get_tree().create_timer(0.1).timeout
	var bodies = get_overlapping_bodies()
	for b in bodies:
		if b.has_method("damage"):
			b.damage(DAMAGE)
	
	started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta *= TimeDilation.time_scale
	if modulate.a <= 0:
		queue_free()
	
	modulate.a -= delta * 2
	scale = lerp(scale, init_size * 1.2, 0.3 * delta)
