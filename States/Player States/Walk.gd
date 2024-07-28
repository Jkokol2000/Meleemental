extends State
class_name Player_Walk

func Enter():
	super()

func Process(delta : float):
	super(delta)
	if not Parent.is_on_floor():
		Transitioned.emit(self, "coyote")
	if Movement_Component.get_jump():
		Transitioned.emit(self, "jump")
	if Movement_Component.get_dash():
		Transitioned.emit(self, "dash")
func Physics_Process(delta : float):
	if Movement_Component.get_movement_direction():
		Parent.velocity.x = Movement_Component.get_movement_direction() * Parent.SPEED
	else:
		Parent.velocity.x = move_toward(Parent.velocity.x, 0, Parent.SPEED)
	if Movement_Component.get_movement_direction() == 0:
		Transitioned.emit(self, "idle")
