extends Enemy

const MAX_HEALTH = 50

const HURT_TIME = 0.2
const DEATH_FADE_TIME = 0.4

const SHAKE_INTERVAL = 0.05
const SHAKE_MAGNITUDE = 6

var shake_timer = 0
var shake_target = Vector2(0, 0)
var hurt_timer = 0

var dead = false

func _ready():
	$HealthBar.max_value = MAX_HEALTH
	health = MAX_HEALTH

func onProcess(_delta):
	$HealthBar.value = health

func onDilatedProcess(delta):
	if (dead):
		process_dying(delta)
		return

	if hurt_timer > 0:
		$Sprite2D.modulate.b = (HURT_TIME - hurt_timer) / HURT_TIME
		$Sprite2D.modulate.g = (HURT_TIME - hurt_timer) / HURT_TIME
		shake(delta)
		hurt_timer -= delta
	else:
		$Sprite2D.modulate.b = 1
		$Sprite2D.offset = Vector2(0, 0)
	
	# shooting logic is in enemy weapon child node

func process_dying(delta):
	self.modulate.a -= delta
	self.modulate.b = 0
	self.modulate.g = 0
	shake(delta)
	if self.modulate.a <= 0:
		queue_free()

func onDie():
	$CollisionShape2D.disabled = true
	dead = true

func onDamage(_val):
	hurt_timer = HURT_TIME

func shake(delta):
	$Sprite2D.offset = $Sprite2D.offset.lerp(shake_target, 0.6)
	if (shake_timer <= 0):
		shake_target = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)) * (hurt_timer / HURT_TIME) * SHAKE_MAGNITUDE
		shake_timer = SHAKE_INTERVAL
	else:
		shake_timer -= delta
