extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Crosshair.global_position = get_global_mouse_position()
	if GlobalPlayer.weapons_manager and GlobalPlayer.weapons_manager.reloading:
		$Crosshair.rotation += delta * 2