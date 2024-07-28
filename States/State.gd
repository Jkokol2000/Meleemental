extends Node
class_name State

signal Transitioned

@export var can_jump : bool = false
@export var can_dash : bool = false

@onready var Parent = get_parent().parent
@onready var Movement_Component = Parent.movement_component

func Enter():
	print(name)
	Parent.update_animations(name)
func Exit():
	pass
func Process(_delta: float):
	pass
func Physics_Process(_delta: float):
	pass
			
	
