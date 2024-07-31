extends Control
class_name DialogueManager

const DIALOGUE_SCENE := preload("res://Scenes/dialogue.tscn")

signal message_requested()
signal message_completed()

signal finished()

var _messages := []
var _active_dialogue_offset := 0
var _is_active := false
var cur_dialogue_instance: Dialogue

func show_messages(message_list: Array, position: Vector2):
	if _is_active:
		return
	_is_active = true
	
	_messages = message_list
	_active_dialogue_offset = 0
	
	var _dialogue = DIALOGUE_SCENE.instantiate()
	get_tree().get_root().add_child(_dialogue)
	
	_dialogue.global_position = position
	
	cur_dialogue_instance = _dialogue
	
	
	_show_current()

func _show_current():
	emit_signal("message_requested")
	var _msg := _messages[_active_dialogue_offset] as String
	cur_dialogue_instance.update_message(_msg)
	
func _input(event):
	if (Input.is_action_just_pressed("Attack")) and _messages.size() != 0:
		if _active_dialogue_offset < _messages.size() - 1:
			_active_dialogue_offset += 1
			_show_current()
		else:
			_hide()
			queue_free()
func _hide():
	cur_dialogue_instance.queue_free()
	cur_dialogue_instance = null
	_is_active = false
	get_tree().paused = false
	emit_signal("finished")

