extends ProgressBar

func _ready():
	if not GlobalPlayer.player:
		return
	max_value = GlobalPlayer.player.MAX_HEALTH

func _process(_delta):
	if not GlobalPlayer.player:
		print("qaugh")
		return
	value = GlobalPlayer.player.health
