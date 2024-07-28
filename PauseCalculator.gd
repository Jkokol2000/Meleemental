
class_name PauseCalculator
extends Node
signal pause_requested(duration)
const PAUSE_PATTERN := "({p=\\d([.]\\d+)?[}])"
var _pause_regex := RegEx.new()
var _pauses := []

func _ready():
	_pause_regex.compile(PAUSE_PATTERN)

func extract_pauses_from_string(source_string: String) -> String:
	_pauses = []
	_find_pauses(source_string)
	return _extract_tags(source_string)

func _find_pauses(from_string):
	var _found_pauses := _pause_regex.search_all(from_string)
	for _result in _found_pauses:
		
		var _tag_string := _result.get_string() as String
		var _tag_position := _adjust_position(
			_result.get_start() as int,
			from_string
		)
		
		var _pause = Pause.new(_tag_position, _tag_string)
		_pauses.append(_pause)

func _extract_tags(from_string):
	var _custom_regex = RegEx.new()
	_custom_regex.compile("({(.*?)})")
	return _custom_regex.sub(from_string, "", true)

func check_at_position(pos):
	for _pause in _pauses:
		if _pause.pause_pos == pos:
			emit_signal("pause_requested", _pause.duration)
func _adjust_position(pos: int, source_string: String) -> int:
	var _custom_tag_regex := RegEx.new()
	_custom_tag_regex.compile("({(.*?)})")
	
	var _new_pos := pos
	var _left_of_pos := source_string.left(pos)
	var _all_prev_tags := _custom_tag_regex.search_all(_left_of_pos)
	
	for _tag_result in _all_prev_tags:
		_new_pos -= _tag_result.get_string().length()
	
	return _new_pos
