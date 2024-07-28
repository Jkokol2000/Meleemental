extends Control
class_name Dialogue

@onready var content = $RichTextLabel
@onready var type_timer = $Type_Timer
@onready var pause_timer = $Pause_Timer
@onready var _calc := $PauseCalculator
func _ready() -> void:
	update_message("This~!{p=0.5} is a test message for the dialogue system. Works like a charm...{p=0.3} right?")
	
func update_message(message: String) -> void:
	content.text = _calc.extract_pauses_from_string(
		message
	)
	content.visible_characters = 0
	type_timer.start()

func _on_type_timer_timeout() -> void:
	_calc.check_at_position(content.visible_characters)
	if content.visible_characters < content.text.length():
		content.visible_characters += 1
	else:
		type_timer.stop()


func _on_pause_calculator_pause_requested(duration):
	type_timer.stop()
	pause_timer.wait_time = duration
	pause_timer.start()

func _on_pause_timer_timeout():
	type_timer.start()
