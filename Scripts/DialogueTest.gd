extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	get_tree().paused = true
	$"../DialogueManager".show_messages([
		"Wow, great job doing soooo much work, Darren.",
		"Wait... {p=0.5} Do I not have a sprite yet!?!?!?",
		"Somebody BETTER get on that or I am going to lose it!"
	], $"../dialogue_position".position)
	queue_free()
