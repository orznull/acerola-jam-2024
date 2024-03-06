extends Weapon

var active = false

const DAMAGE = 10

const DAMAGE_INTERVAL = 0.1
var damage_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	time_cost = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Crosshair.global_position = get_global_mouse_position()
	if shooting:
		if TimeDilation.dilation_time > 0.05:
			$ActiveBar.value = TimeDilation.dilation_time
			
			var collider = $RayCast2D.get_collider()
			if collider:
				
				$Laser.set_point_position(1, to_local(collider.global_position) - offset)
				if collider.has_method("damage") and damage_timer < 0:
					collider.damage(DAMAGE)
					TimeDilation.dilation_time = time_cost
					damage_timer = DAMAGE_INTERVAL
				else:
					damage_timer -= delta
			else:
				$Laser.set_point_position(1, Vector2.RIGHT * 1000)
					
		else:
			shooting = false
	$Laser.visible = shooting
	$ActiveBar.visible = shooting

func onShoot(target_pos: Vector2):
	shooting = true