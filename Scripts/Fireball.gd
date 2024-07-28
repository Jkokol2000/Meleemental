extends Area2D

var base_knockback = Vector2(0, -200)

var Speed = 2
@export var attack = Attack
var enemies_in_ball = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	attack.knockback = base_knockback


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= Speed
	
		

func _on_up_timer_timeout():
	Speed *= -1
	attack.knockback *= -1
func _on_visible_on_screen_notifier_2d_screen_exited():
	$OffscreenTimer.start()


func _on_offscreen_timer_timeout():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	$OffscreenTimer.stop()

func _on_area_entered(area):
	if area.has_method("damage") and area.get_parent().is_in_group("Enemy"):
		enemies_in_ball[area.name] = area
		$DamageTimer.start()


func _on_damage_timer_timeout():
	for area in enemies_in_ball:
		if enemies_in_ball[area] != null:
			enemies_in_ball[area].damage(attack)


func _on_area_exited(area):
	enemies_in_ball[area.name] = null
