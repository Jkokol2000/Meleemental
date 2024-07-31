extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var Bullet : PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var saved_velocity = Vector2.ZERO
var in_hitstun = false
@onready var sprites = $DummySprite

func _physics_process(delta):
	if Input.is_action_just_pressed("enemy_shoot"):
		shoot_bullet()
	if not is_on_floor():
		if in_hitstun == true:
			velocity.y += gravity * delta / 2
		else:
			velocity.y += gravity * delta
	else:
		in_hitstun = false
	if Engine.time_scale == 1:
		velocity = lerp(velocity, Vector2.ZERO, 0.1)
	move_and_slide()
	
func shoot_bullet():
	var b = Bullet.instantiate()
	owner.add_child(b)
	b.direction = -1
	b.transform = self.global_transform
	


func _on_hitbox_component_took_damage():
	gravity = 0
	await get_tree().create_timer(.5).timeout
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
