extends Area2D
class_name HitComponent

signal kill_parent

@export var health_comp : HealthComponent
@export var parent : Node2D

func damage(attack: Attack):
	health_comp.health -= attack.attack_damage
	if health_comp.health <= 0:
		kill_parent.emit()
		health_comp.health = health_comp.MAX_HEALTH
	get_parent().velocity = global_position.normalized() * attack.knockback
