extends EnemyWeapon

var PROJECTILE_SCENE = preload ("res://projectile/basic/basic_enemy_projectile.tscn")

const LINE_INITIAL_WIDTH = 50.0

const SHOOT_INTERVAL = 0.7
var shoot_timer = SHOOT_INTERVAL

const COOLDOWN_INTERVAL = 0.3
var cooldown_timer = COOLDOWN_INTERVAL

var dead = false

func shoot(init_pos: Vector2):
	var player = GlobalPlayer.player
	if player == null:
		return
	var bullet: Projectile = PROJECTILE_SCENE.instantiate()
	get_tree().root.add_child(bullet)
	bullet.init(init_pos, player.position)

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

	rotation = (GlobalPlayer.player.global_position - global_position).angle()

	if cooldown_timer > 0:
		cooldown_timer -= delta
	elif shoot_timer > 0:
		shoot_timer -= delta
	elif shoot_timer <= 0:
		shoot(global_position)
		cooldown_timer = COOLDOWN_INTERVAL
		shoot_timer = SHOOT_INTERVAL
	
func onDie():
	dead = true
