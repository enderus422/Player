extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var time_disp = true
var movimientoActivo= true 
var tipo = ''

@export var bala:PackedScene

@export var inventario = ['cuchillo',"pistola"]
var posiInventario = 1


func _ready():
	$HitboxControler/CollisionShape2D.disabled = true
	$Lacer/CollisionShape2D.disabled = true
	
	
func _physics_process(delta):
	if movimientoActivo:
		#Inventario check // NOTA: esta logica se puede mil veces mejorar pero por tiempo ekisde :/
		if Input.is_action_just_pressed('inv1'):
			posiInventario = 1
		if Input.is_action_just_pressed('inv2') and inventario.has('pistola'):
			posiInventario = 2
		if Input.is_action_just_pressed('inv3') and inventario.has('cosa'):
			posiInventario = 3
		 
		#vamos agregando al array segun que armas encontremos 
		
		if inventario.has('cuchillo') and posiInventario == 1  : 
			if Input.is_action_just_pressed("ui_accept"):
				$HitboxControler/CollisionShape2D.disabled = false
				await get_tree().create_timer(0.2).timeout
				$HitboxControler/CollisionShape2D.disabled = true
				
		if inventario.has('pistola') and posiInventario == 2 : 
			if Input.is_action_just_pressed("ui_accept"):
				balaDisp(tipo)
				
		if inventario.has('cosa') and posiInventario == 3: 
			if Input.is_action_just_pressed("ui_accept"):
				$Lacer/CollisionShape2D.disabled = false
				await get_tree().create_timer(1).timeout
				$Lacer/CollisionShape2D.disabled = true
				
				print("cositas pasando")
		
		
		var direction_x = Input.get_axis("ui_left", "ui_right")
		if direction_x:
			tipo = "Horizontal"
			velocity.x = direction_x * SPEED
			if direction_x == 1:
				$HitboxControler.position = Vector2(38,0) 
				$Marker2D.position = Vector2(40,0) 
				$Lacer.global_rotation_degrees= 0
				print($Lacer.rotation)
				
			elif direction_x == -1:
				$HitboxControler.position = Vector2(-38,0) 
				$Marker2D.position = Vector2(-40,0) 
				$Lacer.global_rotation_degrees= 180
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		var direction_y = Input.get_axis("ui_up", "ui_down")
		if direction_y:
			tipo = "vertical"
			velocity.y = direction_y * SPEED
			if direction_y == 1:
				$HitboxControler.position = Vector2(0,38) 
				$Marker2D.position = Vector2(0,40) 
				$Lacer.global_rotation_degrees= 90
			elif direction_y == -1:
				$HitboxControler.position = Vector2(0,-38) 
				$Marker2D.position = Vector2(0,-40) 
				$Lacer.global_rotation_degrees= -90
				
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

#logica de bala funcion
func balaDisp(Tipo):
	if time_disp :
		var bala_disparar =  bala.instantiate()
		if Tipo == "Horizontal" :
			if $Marker2D.position.x == 40:
				bala_disparar.velocidad_x = 700
				bala_disparar.velocidad_y = 0
				bala_disparar.global_position = $Marker2D.global_position
				
			elif $Marker2D.position.x == -40:
				bala_disparar.velocidad_x = -700
				bala_disparar.velocidad_y = 0
				bala_disparar.global_position = $Marker2D.global_position
				
		elif Tipo == "vertical" :
			if $Marker2D.position.y == 40:
				bala_disparar.velocidad_x= 0
				bala_disparar.velocidad_y = 700
				bala_disparar.global_position = $Marker2D.global_position
			elif $Marker2D.position.y == -40:
				bala_disparar.velocidad_x= 0
				bala_disparar.velocidad_y = -700
				bala_disparar.global_position = $Marker2D.global_position
			get_parent().add_child(bala_disparar)
			 
		get_parent().add_child(bala_disparar)
		time_disp = false
		await get_tree().create_timer(0.6).timeout
		time_disp = true
	
	
func player():
	pass
	
func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		if inventario.has('pistola'):
			inventario.append('cosa')
			return
		else:
			inventario.append('pistola')


func _on_prueba_cam_tran_dere():
	movimientoActivo = false 
	await get_tree().create_timer(1).timeout
	movimientoActivo = true
	pass # Replace with function body.

func _on_health_component_on_dead():
	self.queue_free()

