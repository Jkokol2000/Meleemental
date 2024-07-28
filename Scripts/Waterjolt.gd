extends Area2D

@export var attack : Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.43).timeout
	queue_free()
	
func _on_area_entered(area):
	if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
		area.damage(attack)
