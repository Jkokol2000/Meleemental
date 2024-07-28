extends Marker2D

@onready
var current_flip = $"../PlayerAnim".flip_h
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_flip != $"../PlayerAnim".flip_h:
		position.x *= -1
		current_flip = $"../PlayerAnim".flip_h
