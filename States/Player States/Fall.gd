extends State
class_name Player_Fall

var base_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	super()

func Physics_Process(delta):
	if not Parent.is_on_floor():
		Parent.velocity.y += Parent.gravity * delta
		if Movement_Component.get_movement_direction():
			Parent.velocity.x = (Movement_Component.get_movement_direction() * Parent.SPEED)
func Process(delta):
	if Parent.is_on_floor():
		if Movement_Component.get_jump():
			Transitioned.emit(self, "jump")
		if Movement_Component.get_movement_direction():
			Transitioned.emit(self, "walk")
		Transitioned.emit(self, "idle")
func Exit():
	Parent.gravity = base_gravity
func _on_attack_component_get_next_attack():
	Transitioned.emit(self, "ground_attack_1")
