extends Node2D
class_name HealthComponent 

@export
var parent: CharacterBody2D

@export var MAX_HEALTH : int
var health : int
var knock_direction = 1
func _ready():
	health = MAX_HEALTH
	
func damage(attack: Attack):
	health -= attack.attack_damage
	if health <= 0:
		print("Death")
		health = MAX_HEALTH
	get_parent().velocity = global_position.normalized() * attack.knockback * knock_direction
	print(knock_direction)

