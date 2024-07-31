extends CollisionShape2D

var current_flip_value
# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(20,12)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../../PlayerAnim".flip_h:
		position = Vector2(-240,12)
	else:
		position = Vector2(20,12)


func _on_player_anim_sprite_flipped(value):
	pass
