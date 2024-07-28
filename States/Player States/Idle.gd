extends State
class_name Player_Idle

func Enter():
	super()
	Parent.velocity.x = 0
func Process(delta : float):
	if Movement_Component.get_jump():
		Transitioned.emit(self, "jump")
	if Movement_Component.get_dash():
		Transitioned.emit(self, "dash")
	if not Parent.is_on_floor():
		Transitioned.emit(self, "coyote")
func Physics_Process(delta : float):
	super(delta)
	if Movement_Component.get_movement_direction() != 0:
		Transitioned.emit(self, "walk")
func _on_attack_component_get_next_attack():
	Transitioned.emit(self, "ground_attack_1")
