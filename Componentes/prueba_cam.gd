extends Node2D
signal TranDere 


func _ready():
	pass 

func _process(delta):
	pass

func _on_derecha_body_entered(body):
	if body.has_method("player"):
		emit_signal("TranDere")
		$AnimationPlayer.play("derecha_1")
