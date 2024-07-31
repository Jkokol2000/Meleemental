extends Area2D

@export var speed = 350
@export var steer_force = 250.0
@export var attack : Attack

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null

func start(_transform, _target):
	global_transform = _transform
	rotation += randf_range(-0.09, 0.09)
	velocity = transform.x * speed
	target = _target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

func process():
	pass

func _physics_process(delta):
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(speed)
	rotation = velocity.angle()
	position += velocity * delta
	

func explode():
	queue_free()


func _on_area_entered(area):
	print(area.has_method("damage"))
	if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
		area.damage(attack)
		explode()


func _on_lifetime_timeout():
	explode()
