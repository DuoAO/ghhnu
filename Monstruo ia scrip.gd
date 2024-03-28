extends CharacterBody2D

var velocidad = 100 # Velocidad de movimiento del monstruo
var tiempo_espera = 3.0 # Tiempo de espera entre movimientos

var direccion = Vector2.RIGHT # Dirección inicial del movimiento

func _ready():
	set_process(true)

func _fixed_process(delta):
	# Cambiar la dirección del movimiento
	if direccion == Vector2.RIGHT:
		direccion = Vector2.LEFT
	else:
		direccion = Vector2.RIGHT
