extends Area2D
var speed = 500
@export var attack : Attack
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * speed * direction * delta


func _on_area_entered(area):
	if area.has_method("damage") and area.get_parent().is_in_group("Player"):
		area.damage(attack)
		queue_free()
