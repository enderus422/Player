extends Area2D
class_name HitboxComponent

@export var damage: int = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(_on_area_entered)

func _process(delta):
	pass


func _on_area_entered(area):
	if area is HealthComponent:
		area.take_damage(damage)
