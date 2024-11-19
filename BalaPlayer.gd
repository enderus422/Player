extends CharacterBody2D
class_name armaPlayer

var velocidad_x:int
var velocidad_y:int



func _process(delta):
	self.position.x += velocidad_x * delta
	self.position.y += velocidad_y *delta
	pass

func balaPlayer():
	pass


func _on_hitbox_controler_body_entered(body):
	#si el cuerpo es distinto a yo mismo me destruyo (danery : "es muy aweona esta linea")
	if body != $".":
		self.queue_free()


		
