extends Area2D
class_name HitboxComponent

signal took_damage

@export var health_component: HealthComponent

func damage(attack: Attack):
	took_damage.emit()
	if get_parent().in_hitstun != null:
		get_parent().in_hitstun = true
	if health_component:
		health_component.damage(attack)
	
