extends CharacterBody2D

@onready var sprites : AnimatedSprite2D = $PlayerAnim
@onready var animation_tree : AnimationTree = $PlayerAnimTree
@export var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
var in_hitstun
@export var movement_component : MovementComponent

var anim_dict = {"Idle" : "parameters/conditions/is_idle", "Walk" : "parameters/conditions/is_moving", "Jump" : "parameters/conditions/is_jumping", "Fall" : "parameters/conditions/is_falling", "Coyote" : "parameters/conditions/is_falling", "Ground_Attack_1" : "parameters/conditions/first_attack", "Ground_Attack_2" : "parameters/conditions/second_attack", "Ground_Attack_Finisher_Regular" : "parameters/conditions/final_attack_regular",  "Ground_Attack_Finisher_Up" : "parameters/conditions/final_attack_up", "Dash" : "parameters/conditions/is_dashing", "Hurt" : "parameters/conditions/is_hurt", "Ground_Attack_Finisher_Forward": "parameters/conditions/final_attack_forward", "Ground_Attack_Finisher_Down": "parameters/conditions/final_attack_down", "Ground_Attack_Finisher_Back": "parameters/conditions/final_attack_back"}
var direction
@export var anti_grav = false

const SPEED = 300.0
const JUMP_FORCE = 500.0

func _ready():
	anti_grav = false

func _process(delta):
	pass

func _physics_process(delta):
	if anti_grav == true:
		gravity = 100
	else:
		gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	move_and_slide()

func update_animations(anim):
	if animation_tree != null:
		for animation in anim_dict:
			animation_tree[anim_dict[animation]] = false
		animation_tree[anim_dict[anim]] = true
	else:
		pass


	
