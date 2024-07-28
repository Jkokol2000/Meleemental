extends Node2D
class_name HealthComponent 

@export
var parent: CharacterBody2D

@export var MAX_HEALTH := 9999
var health : int

func _ready():
	health = MAX_HEALTH
func damage(attack: Attack):
	health -= attack.attack_damage
	$"../Label".text = str(health) + " / " + str(MAX_HEALTH)
	if health <= 0:
		health = MAX_HEALTH
	get_parent().velocity = global_position.normalized() * attack.knockback
