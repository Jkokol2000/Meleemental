extends Area2D
class_name AttackComponent

signal get_next_attack
signal charge_element(element)

var current_attack : Attack
var _attack_buffer = Buffer.new(0.4, 0.4)
var knock_direction
var last_charged_element = "None"

func attack(attack: Attack, body):
		print("Damaging")
		body.damage(attack)
func _process(delta):
	if $"../PlayerAnim".flip_h == true:
		knock_direction = -1
	else:
		knock_direction = 1
	if "attack_stats" in $"../State Machine".current_state:
		current_attack = $"../State Machine".current_state.attack_stats
		_attack_buffer.update(
			Input.is_action_just_pressed("Attack"),
			$"../State Machine".current_state.can_combo,
			delta
			)
		if _attack_buffer.should_run_action():
			emit_signal("get_next_attack")
	else:
		if Input.is_action_just_pressed("Attack"):
			emit_signal("get_next_attack")
				

func _on_area_entered(area):
	current_attack.knockback.x *= knock_direction
	if current_attack.element != "None":
		charge_element.emit(current_attack.element)
		current_attack.element = "None"
	while has_overlapping_areas():
		if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
			attack(current_attack, area)
			await get_tree().create_timer(.35).timeout
	
			

