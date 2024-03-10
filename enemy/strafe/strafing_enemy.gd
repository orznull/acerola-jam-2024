extends Enemy

const MAX_HEALTH = 2000

const HURT_TIME = 0.2
const DEATH_FADE_TIME = 0.4

const SHAKE_INTERVAL = 0.05
const SHAKE_MAGNITUDE = 6

var shake_timer = 0
var shake_target = Vector2(0, 0)
var hurt_timer = 0

var dead = false

@export var TARGET_RADIUS = 300.0
@export var SPEED = 400.0
enum StrafeBehavior {RUN_AWAY, RUN_TOWARDS, MAINTAIN_DISTANCE}
@export var STRAFE_BEHAVIOR: StrafeBehavior = StrafeBehavior.RUN_TOWARDS

var direction_around = 1

func _ready():
	$HealthBar.max_value = MAX_HEALTH
	health = MAX_HEALTH

func onProcess(_delta):
	$HealthBar.value = health

func onDilatedProcess(delta):
	if (dead):
		process_dying(delta)
		return

	process_moving(delta)

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
	direction_around = direction_around * - 1

func shake(delta):
	$Sprite2D.offset = $Sprite2D.offset.lerp(shake_target, 0.6)
	if (shake_timer <= 0):
		shake_target = Vector2(randf_range( - 1, 1), randf_range( - 1, 1)) * (hurt_timer / HURT_TIME) * SHAKE_MAGNITUDE
		shake_timer = SHAKE_INTERVAL
	else:
		shake_timer -= delta

func process_moving(delta):
	if not GlobalPlayer.player:
		return
	if STRAFE_BEHAVIOR == StrafeBehavior.RUN_AWAY:
		move_away()
	elif STRAFE_BEHAVIOR == StrafeBehavior.RUN_TOWARDS:
		move_towards()
	else:
		maintain_distance()

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		direction_around = direction_around * - 1

func move_away():
	var to_player = GlobalPlayer.player.global_position - global_position
	if to_player.distance_to(Vector2.ZERO) < TARGET_RADIUS:
		velocity = -SPEED * to_player.normalized()
	else:
		velocity = SPEED * to_player.normalized().rotated(direction_around * PI / 2)

func move_towards():
	var to_player = GlobalPlayer.player.global_position - global_position
	if to_player.distance_to(Vector2.ZERO) > TARGET_RADIUS:
		velocity = SPEED * to_player.normalized()
	else:
		velocity = SPEED * to_player.normalized().rotated(direction_around * PI / 2)
	
const DISTANCE_TOLERANCE = 50
func maintain_distance():
	var to_player = GlobalPlayer.player.global_position - global_position
	var distance = to_player.distance_to(Vector2.ZERO)
	if abs(distance - TARGET_RADIUS) > DISTANCE_TOLERANCE:
		velocity = SPEED * to_player.normalized() * sign(distance - TARGET_RADIUS)
	else:
		velocity = SPEED * to_player.normalized().rotated(direction_around * PI / 2)
