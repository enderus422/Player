extends CharacterBody2D

func _ready():
	pass


func _on_health_component_on_dead():
	self.queue_free()
