extends State

var time_to_dash = 0.5

var dash_timer = 0.20
var direction = 1.0

func Enter():
	if Parent.sprites.flip_h:
		direction = -1.0
	else:
		direction = 1
	
	
func Process(delta):
	super(delta)

func Physics_Process(delta):
	Parent.velocity.x = 2000 * direction
	await get_tree().create_timer(dash_timer).timeout
	if Movement_Component.get_movement_direction():
		Transitioned.emit(self, "Walk")
	Transitioned.emit(self, "Idle")

func Exit():
	Parent.velocity.x = 0
