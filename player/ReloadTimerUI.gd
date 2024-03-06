extends ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if GlobalPlayer.weapons_manager and GlobalPlayer.weapons_manager.reloading:
		max_value = GlobalPlayer.weapons_manager.RELOAD_TIME
		value = GlobalPlayer.weapons_manager.RELOAD_TIME - GlobalPlayer.weapons_manager.reloading_timer
		visible = true
	else:
		visible = false