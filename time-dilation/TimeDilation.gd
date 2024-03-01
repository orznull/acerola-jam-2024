# Singleton for controlling time dilation.

extends Node

@export var time_scale: float = 1.0
@export var dilation_time = 0

func dilation_active():
	return dilation_time > 0

func _process(delta):
	dilation_time = max(dilation_time - delta, 0)
	if !dilation_active():
		time_scale = lerp(time_scale, 0.0, 0.3)

func bump_time_scale(scale: float):
	time_scale = max(scale, time_scale)
