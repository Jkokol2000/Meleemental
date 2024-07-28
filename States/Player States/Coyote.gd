extends Player_Fall
class_name Player_Coyote

@export var coyote_time = .1

func Enter():
	super()
	get_tree().create_timer(coyote_time).timeout.connect(on_coyote_time_timeout)
	
func Process(delta : float):
	super(delta)
	if Movement_Component.get_jump():
		Transitioned.emit(self, "jump")

		
func Physics_Process(delta : float):
	if not Parent.is_on_floor():
		Parent.velocity.y += Parent.gravity * delta
	
func on_coyote_time_timeout():
	Transitioned.emit(self, "fall")
