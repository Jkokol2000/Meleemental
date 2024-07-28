extends CharacterBody2D

var current_mode = "follow"

@export
var Player : CharacterBody2D
@onready
var follow_point = Player.get_node("follow_point")
@onready
var timer : Timer = $Timer

var follow_wait = 3

var direction = Vector2.ZERO
var element_index = 0

@export
var spell_resources : Array

var spell_array = ["None", "None"]

const SPEED = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	var target = follow_point.global_position
	if current_mode == "follow":
		velocity = Vector2.ZERO
		if position.distance_to(target) > 5:
			velocity = position.direction_to(target) * SPEED
		if direction:
			current_mode = "move"
	if current_mode == "move":
		if direction:
			velocity = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()

func _input(event):
		direction.x = Input.get_axis("float_left", "float_right")
		direction.y = Input.get_axis("float_up", "float_down")
		if !direction and velocity < Vector2(1,1):
			timer.start()
		else:
			timer.stop()
		
		if Input.is_action_just_pressed("cast"):
			cast_spell(spell_array)
			

func _on_timer_timeout():
	current_mode = "follow"

func cast_spell(array):
	print(array)
	for sp in spell_resources:
		for element in sp.formula:
			if element == array:
				spawn_spell(sp.scene)
	spell_array = ["None", "None"]
		
func spawn_spell(scene : PackedScene):
	print(scene.resource_path)
	match scene.resource_path:
		"res://firebolt.tscn":
			print("firebolt")
			var b = scene.instantiate()
			get_parent().add_child(b)
			b.start(self.global_transform, find_closest_enemy())
		"res://Resource/Attacks/Waterjolt.tscn":
			print("waterjolt")
			var b = scene.instantiate()
			get_parent().add_child(b)
			b.global_transform = self.global_transform
		"res://fireball.tscn":
			print("fireball")
			var b = scene.instantiate()
			get_parent().add_child(b)
			b.global_transform = self.global_transform
		_:
			print("No Spell Scene")

func _on_attack_component_charge_element(element):
	if element != "None":
		spell_array[element_index] = element
		if element_index == 0:
			element_index = 1
		else:
			element_index = 0
		
	
func find_closest_enemy():
	var closest_pos
	for child in get_tree().get_nodes_in_group("Enemy"):
		if closest_pos == null or Player.global_position.distance_to(Player.global_position) < closest_pos.global_position.distance_to(Player.global_position):
			closest_pos = child
	return closest_pos
