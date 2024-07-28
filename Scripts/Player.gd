extends CharacterBody2D

@onready var sprites : AnimatedSprite2D = $PlayerAnim
@onready var animation_tree : AnimationTree = $PlayerAnimTree
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var movement_component : MovementComponent

var anim_dict = {"Idle" : "parameters/conditions/is_idle", "Walk" : "parameters/conditions/is_moving", "Jump" : "parameters/conditions/is_jumping", "Fall" : "parameters/conditions/is_falling", "Coyote" : "parameters/conditions/is_falling", "Ground_Attack_1" : "parameters/conditions/first_attack", "Ground_Attack_2" : "parameters/conditions/second_attack", "Ground_Attack_Finisher_Regular" : "parameters/conditions/final_attack_regular",  "Ground_Attack_Finisher_Up" : "parameters/conditions/final_attack_up"}
var direction

const SPEED = 300.0
const JUMP_FORCE = 1000.0


func _process(delta):
	if movement_component.get_movement_direction() == 1:
		sprites.flip_h = false
	elif movement_component.get_movement_direction() == -1:
		sprites.flip_h = true

func _physics_process(delta):
	move_and_slide()

func update_animations(anim):
	if animation_tree != null:
		for animation in anim_dict:
			animation_tree[anim_dict[animation]] = false
		animation_tree[anim_dict[anim]] = true
	else:
		pass


	
