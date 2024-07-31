extends Label

@export
var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../Label".text = str(health_component.health) + " / " + str(health_component.MAX_HEALTH)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"../Label".text = str(health_component.health) + " / " + str(health_component.MAX_HEALTH)
