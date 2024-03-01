extends Enemy

const MAX_HEALTH = 30


const HURT_TIME = 0.4
const DEATH_FADE_TIME = 0.5
const SHAKE_MAGNITUDE = 5

var hurt_timer = 0

var dead = false

func _ready():
	$HealthBar.max_value = MAX_HEALTH
	health = MAX_HEALTH

func _process(delta):
	
	$HealthBar.value = health
	
	if (dead):
		process_dying(delta)
		return
	
	if hurt_timer > 0:
		$Sprite2D.modulate.b = (HURT_TIME - hurt_timer) / HURT_TIME
		$Sprite2D.modulate.g = (HURT_TIME - hurt_timer) / HURT_TIME
		$Sprite2D.offset.x = randf_range( - 1, 1) * (hurt_timer / HURT_TIME) * SHAKE_MAGNITUDE
		$Sprite2D.offset.y = randf_range( - 1, 1) * (hurt_timer / HURT_TIME) * SHAKE_MAGNITUDE
		hurt_timer -= delta
	else:
		$Sprite2D.modulate.b = 1
		$Sprite2D.offset = Vector2(0, 0)

func process_dying(delta):
	self.modulate.a -= delta
	self.modulate.b = 0
	self.modulate.g = 0
	$Sprite2D.offset.x = randf_range( - 1, 1) * SHAKE_MAGNITUDE
	$Sprite2D.offset.y = randf_range( - 1, 1) * SHAKE_MAGNITUDE
	if self.modulate.a <= 0:
		queue_free()

func die():
	$CollisionShape2D.disabled = true
	dead = true

func damage(val):
	super.damage(val)
	hurt_timer = HURT_TIME
