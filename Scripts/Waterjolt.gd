extends Area2D

@export var attack : Attack

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("Bolt")
func _on_area_entered(area):
	if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
		area.damage(attack)
		
func adjust_knockback(direction):
	attack.knockback *= direction


func _on_animated_sprite_2d_animation_finished():
	queue_free()
