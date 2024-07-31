extends Node
class_name State_Machine

@export var initial_state : State
@export var parent : Node

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			print(child)
			
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
func _process(delta):
	if current_state:
		current_state.Process(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Process(delta)
		
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state


func _on_hitbox_component_took_damage():
	current_state.Transitioned.emit(current_state, "hurt")
