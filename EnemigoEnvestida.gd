extends CharacterBody2D


const SPEED = 500.0
var direccionDetect_x= 0
var direccionDetect_y=0
var playerDetect= false

func _ready():
	pass

func _physics_process(delta):
	var direction_x = direccionDetect_x
	var direction_y = direccionDetect_y
	
	if direction_x:
		velocity.x = direccionDetect_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y:
		velocity.y = direccionDetect_y * SPEED
	else:
		velocity.y = move_toward(velocity.x, 0, SPEED)
	move_and_slide()



func _on_arriba_body_entered(body):
	if body.has_method("player") and !playerDetect :
		await get_tree().create_timer(0.5).timeout
		direccionDetect_y = -1
		playerDetect=true
		await get_tree().create_timer(1).timeout
		playerDetect = false
		direccionDetect_y = 0
	
func _on_abajo_body_entered(body):
	if body.has_method("player") and !playerDetect :
		await get_tree().create_timer(0.5).timeout
		direccionDetect_y = 1
		playerDetect=true
		await get_tree().create_timer(1).timeout
		playerDetect = false
		direccionDetect_y = 0


func _on_derecha_body_entered(body):
	if body.has_method("player") and !playerDetect:
		await get_tree().create_timer(0.5).timeout
		direccionDetect_x = 1
		playerDetect=true
		await get_tree().create_timer(1).timeout
		playerDetect = false
		direccionDetect_x = 0

		
func _on_izquierda_body_entered(body):
	if body.has_method("player")and !playerDetect:
		await get_tree().create_timer(0.5).timeout
		direccionDetect_x = -1
		playerDetect=true
		await get_tree().create_timer(1).timeout
		playerDetect = false
		direccionDetect_x = 0


func _on_health_component_on_dead():
	self.queue_free()
	pass # Replace with function body.
