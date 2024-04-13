extends CharacterBody2D

# Parámetros de movimiento
const SPEED = 50
const TURN_DELAY = 2
const MIN_DISTANCE = 50
const MAX_DISTANCE = 200

var velocity = Vector2()
var target_position = Vector2()
var turn_timer = 0

func _ready():
	set_process(true)

func _process(delta):
	turn_timer -= delta
	if turn_timer <= 0:
		# Cambiar la dirección después de un tiempo aleatorio
		target_position = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized() * rand_range(MIN_DISTANCE, MAX_DISTANCE)
		turn_timer = TURN_DELAY
	
	velocity = (target_position - position).normalized() * SPEED

	# Detectar colisiones y ajustar la dirección si hay una colisión
	if is_colliding():
		var collision = get_collider()
		if collision != null:
			target_position = position + velocity.normalized() * MIN_DISTANCE

	move_and_slide()
