extends CollisionShape2D

var current_flip_value: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_anim_sprite_flipped(value):
	if current_flip_value != value:
		position.x *= -1
		current_flip_value = value
