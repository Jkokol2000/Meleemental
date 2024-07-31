extends Area2D

var speed = 100
var direction = Vector2.ZERO
var hits_to_pop = 3
@export var attack : Attack
var stuck_area
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	direction = Vector2(randf_range(-1,1), 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	if stuck_area:
		stuck_area.global_position = global_position



func _on_area_entered(area):
	if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
		area.damage(attack)
		stuck_area = area.get_parent()
	if area.collision_mask == 2:
		hits_to_pop -= 1
		if hits_to_pop == 0:
			pop()


func _on_body_entered(body):
	if body.is_in_group("Floor"):
		direction *= -1

func pop():
	queue_free()


func _on_timer_timeout():
	pop()
