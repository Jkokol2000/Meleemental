extends AnimatedSprite2D

signal sprite_flipped(value)


var flipped: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flip_h != flipped:
		sprite_flipped.emit(flip_h)
		flipped = flip_h
