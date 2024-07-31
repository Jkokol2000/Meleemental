extends State
	
func Enter():
	super()

func Physics_Process(delta):
	if not Parent.is_on_floor():
		Parent.velocity.y += Parent.gravity * delta
func _on_player_anim_tree_animation_finished(anim_name):
	if Parent.is_on_floor():
		Transitioned.emit(self, "Idle")
	else:
		Transitioned.emit(self, "Fall")
