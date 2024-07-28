extends Node

var current_hitstop = 0

func hit_stop(multiplier : int):
	current_hitstop = multiplier
	Engine.time_scale = 0
	await get_tree().create_timer(.15 * multiplier, true, false, true).timeout
	Engine.time_scale = 1
