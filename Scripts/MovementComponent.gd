extends Node2D
class_name MovementComponent

var buffer_time = .2

var _jump_buffer = Buffer.new(buffer_time, true)
var _dash_buffer = Buffer.new(buffer_time)

var should_jump = false
var should_dash = false

func _process(delta):
	_jump_buffer.update(
		Input.is_action_just_pressed("jump"),
		get_parent().is_on_floor(),
		delta,
	)
	if get_movement_direction() and $"../State Machine".current_state.can_turn == true:
		if get_movement_direction() == 1:
			get_parent().sprites.flip_h = false
		elif get_movement_direction() == -1:
			get_parent().sprites.flip_h = true

func get_movement_direction():
	return Input.get_axis("move_left", "move_right")
func get_jump():
	if _jump_buffer.should_run_action():
		return true
func get_dash() -> bool:
	return Input.is_action_just_pressed("dash")
