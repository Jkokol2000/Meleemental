extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print(body)
	get_tree().paused = true
	$"../DialogueManager".show_messages([
		"Hello! Thanks for trying our prototype",
		"As you can see, its still super early in development...",
		"For now, you can walk around, attack the dummy, and basic stuff",
		"You can even cast a spell! Just hit the dummy with this spell combo:",
		"Fire + Wind",
		"Then hit [I]"
	], $"../Player/dialogue_position".global_position)
	queue_free()


func _on_area_entered(area):
	if area.get_parent().is_in_group("Player"):
		get_tree().paused = true
	$"../DialogueManager".show_messages([
		"Hello! Thanks for trying our prototype. (Press U to continue)",
		"As you can see, its still super early in development...",
		"For now, you can walk around, attack the dummy with U, and hold a direction plus attack to do an elemental attack.",
		"You can even cast a spell! Just hit the dummy with this spell combo:",
		"Fire + Wind",
		"Then hit [I], the spell will come from your Homunculus, Alchfra."
	], $"../Player/dialogue_position".global_position)
	queue_free()
