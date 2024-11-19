extends Area2D

@export var damage: int = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(hit)
	pass # Replace with function body.

func hit(area):
	if area is HealthComponent:
			area.take_damage(damage)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
