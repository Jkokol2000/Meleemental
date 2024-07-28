extends Area2D
class_name AttackComponent

signal get_next_attack
signal charge_element(element)

var current_attack : Attack
var _attack_buffer = Buffer.new(0.4, 0.4)

func attack(attack: Attack, body):
		print("Damaging")
		body.damage(attack)
func _process(delta):
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
func apply_hitstop():
	match $"../State Machine".current_state.hitstop:
			"Short":
				HitstopManager.hit_stop(1)
			"Medium":
				HitstopManager.hit_stop(2)
				

func _on_area_entered(area):
	if current_attack.element != "None":
		charge_element.emit(current_attack.element)
		print(current_attack.element)
	if area.has_method("damage"):
		apply_hitstop()
		attack(current_attack, area)

