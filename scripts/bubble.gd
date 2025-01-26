extends RigidBody2D

# Magnitud del impulso
@export var impulse_strength: float = 500.0

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		# Obtén la dirección desde la posición del mouse
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()

		# Aplica el impulso en la direc
		apply_impulse(direction * impulse_strength)
