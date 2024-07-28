extends State
class_name Player_Jump

func Enter():
	super()
	Parent.velocity.y -= Parent.JUMP_FORCE

func Process(delta : float):
	super(delta)
	if !Parent.is_on_floor():
		Parent.velocity.y += Parent.gravity * delta
		if Movement_Component.get_movement_direction():
			Parent.velocity.x = (Movement_Component.get_movement_direction() * Parent.SPEED) / 2
	if Parent.velocity.y > 0:
		Transitioned.emit(self, "fall")

func Exit():
	Parent.gravity *= 1.5
