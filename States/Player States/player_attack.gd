extends State
class_name Player_Attack

@export var next_attack : State
@export var up_attack : State
@export var attack_stats : Attack
@export var can_combo : bool = false
@export var attack_end = false
@export var hitstop : String
var current_flip_value = false
var self_knockback_mult = 1

func Enter():
	super()
	can_combo = false
	attack_end = false
	$"../../AttackComponent/AttackShape".disabled = true
	if attack_stats.self_knockback != Vector2.ZERO:
		Parent.velocity.x += attack_stats.self_knockback.x * self_knockback_mult
		Parent.velocity.y += attack_stats.self_knockback.y

func Process(delta):
	super(delta)
	if attack_end == true:
		if Movement_Component.get_movement_direction() != 0:
			Transitioned.emit(self, "walk")
		Transitioned.emit(self, "idle")

func _on_player_anim_tree_animation_finished(anim_name):
	Transitioned.emit(self, "idle")

func _on_player_anim_sprite_flipped(value):
	if current_flip_value != value:
		self_knockback_mult *= -1
		current_flip_value = value


func _on_attack_component_get_next_attack():
	if up_attack != null and can_combo == true and Input.is_action_pressed("up_modifier"):
		Transitioned.emit(self, up_attack.name)
	if next_attack != null and can_combo == true:
		Transitioned.emit(self, next_attack.name)

func Exit():
	await get_tree().create_timer(.1).timeout
	$"../../AttackComponent/AttackShape".disabled = true
