extends State
class_name Player_Attack

@export var next_attack : State
@export var up_attack : State
@export var down_attack : State
@export var back_attack : State
@export var forward_attack : State
@export var attack_stats : Attack
var can_combo : bool = false
var attack_end = false
@export var hitstop : String
var current_flip_value = false
var knock_direction
var attack_element

func Enter():
	super()
	attack_element = attack_stats.element
	if Parent.sprites.flip_h == true:
			knock_direction = -1
	else:
			knock_direction = 1
	can_combo = false
	attack_end = false
	$"../../AttackComponent/AttackShape".disabled = true
	if attack_stats.self_knockback != Vector2.ZERO:
		Parent.velocity.x += attack_stats.self_knockback.x * knock_direction
		print(attack_stats.self_knockback.x)
		Parent.velocity.y += attack_stats.self_knockback.y

func Process(delta):
	pass

func _on_player_anim_tree_animation_finished(anim_name):
	if !Parent.is_on_floor():
		Transitioned.emit(self, "fall")
	Transitioned.emit(self, "idle")


func _on_attack_component_get_next_attack():
	if up_attack != null and can_combo == true and Input.is_action_pressed("up_modifier"):
		Transitioned.emit(self, up_attack.name)
	if down_attack != null and can_combo == true and Input.is_action_pressed("down_modifier"):
		Transitioned.emit(self, down_attack.name)
	if forward_attack != null and can_combo == true and Input.is_action_pressed("move_right"):
		if Parent.sprites.flip_h != true:
			Transitioned.emit(self, forward_attack.name)
		else:
			Transitioned.emit(self, back_attack.name)
	if back_attack != null and can_combo == true and Input.is_action_pressed("move_left"):
		if Parent.sprites.flip_h != true:
			Transitioned.emit(self, back_attack.name)
		else:
			Transitioned.emit(self, forward_attack.name)
	if next_attack != null and can_combo == true:
		Transitioned.emit(self, next_attack.name)


func Exit():
	await get_tree().create_timer(.1).timeout
	for child in $"../../AttackComponent".get_children():
		child.disabled = true
	attack_stats.element = attack_element

func Physics_Process(delta):
		if not Parent.is_on_floor():
			Parent.velocity.y += Parent.gravity * delta / 2
		if Movement_Component.get_jump() and can_jump == true:
			Transitioned.emit(self, "jump")
	
