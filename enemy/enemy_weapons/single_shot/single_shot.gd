extends EnemyWeapon

var PROJECTILE_SCENE = preload ("res://projectile/basic/basic_enemy_projectile.tscn")

@export var ROTATION_SPEED = 2

@export var LINE_INITIAL_WIDTH = 50.0

@export var SHOOT_INTERVAL = 0.7
var shoot_timer = SHOOT_INTERVAL

@export var COOLDOWN_INTERVAL = 0.3
var cooldown_timer = COOLDOWN_INTERVAL

var dead = false

func _ready():
	if (GlobalPlayer.player):
		rotation = (GlobalPlayer.player.global_position - global_position).angle()

func shoot():
	var player = GlobalPlayer.player
	if player == null:
		return
	var bullet: Projectile = PROJECTILE_SCENE.instantiate()
	get_tree().root.add_child(bullet)
	bullet.init(global_position, global_position + Vector2.RIGHT.rotated(rotation))

func onDilatedProcess(delta):

	if (dead):
		$IndicatorLine.width = 0
		return

	process_shooting(delta)
	
	if cooldown_timer < 0:
		$IndicatorLine.points[1] = Vector2(10000, 0)
		$IndicatorLine.width = max(LINE_INITIAL_WIDTH * (shoot_timer / SHOOT_INTERVAL), 5)
	else:
		$IndicatorLine.width = 0

func process_shooting(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	elif shoot_timer > 0:
		shoot_timer -= delta

		var target = (GlobalPlayer.player.global_position - global_position).angle()
		var angle_diff = fposmod(target - rotation, TAU)
		if angle_diff > PI:
			angle_diff -= TAU
		
		rotation = move_toward(rotation, rotation + angle_diff, delta * ROTATION_SPEED)

	elif shoot_timer <= 0:
		shoot()
		cooldown_timer = COOLDOWN_INTERVAL
		shoot_timer = SHOOT_INTERVAL
	
func onDie():
	dead = true
