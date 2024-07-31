extends State

var time_to_dash = 0.5
@export var dash_speed : int
var dash_timer = 0.20
var direction = 1.0
var dash_finished = false

func Enter():
	super()
	$"../../PlayerAnimTree".set("parameters/TimeScale/scale", 30.0)
	dash_finished = false
	if Parent.sprites.flip_h:
		direction = -1.0
	else:
		direction = 1
	
	
func Process(delta):
	pass

func Physics_Process(delta):
	print(dash_finished)
	Parent.velocity.x = dash_speed * direction
	if dash_finished == true:
		if Movement_Component.get_movement_direction():
			Transitioned.emit(self, "Walk")
		if !Parent.is_on_floor():
			Transitioned.emit(self, "Coyote")
		Transitioned.emit(self, "Idle")

func Exit():
	Parent.velocity.x = 0
	$"../../PlayerAnimTree".set("parameters/TimeScale/scale", 1.0)


func _on_player_anim_tree_animation_finished(anim_name):
	if anim_name == "Dash":
		dash_finished = true
