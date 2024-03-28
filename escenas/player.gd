extends CharacterBody2D

const GRID_SIZE = 24
const ADDITIONAL_SPEED = 160
var target_position = Vector2() # Posición a la que el jugador se moverá

func _physics_process(delta):
	# Capturar pulsaciones del teclado
	var movement = Vector2()
	if Input.is_action_pressed("ui_right"):
		movement.x += GRID_SIZE
	if Input.is_action_pressed("ui_left"):
		movement.x -= GRID_SIZE
	if Input.is_action_pressed("ui_down"):
		movement.y += GRID_SIZE
	if Input.is_action_pressed("ui_up"):
		movement.y -= GRID_SIZE

	# Limitar el movimiento a incrementos de 24x24 píxeles
	target_position = position + movement
	target_position.x = round(target_position.x / GRID_SIZE) * GRID_SIZE
	target_position.y = round(target_position.y / GRID_SIZE) * GRID_SIZE

	# Calcular la dirección y la magnitud del movimiento
	var move_dir = (target_position - position).normalized()
	var move_amount = min((target_position - position).length(), ADDITIONAL_SPEED * delta)


	# Detectar colisiones y mover al jugador
	var collision = move_and_collide(move_dir * move_amount)
