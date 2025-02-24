extends RigidBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Magnitud del impulso
@export var impulse_strength: float = 500.0

# Para rastrear si el jugador ya hizo clic
var has_clicked: bool = false

# Para evitar cambios innecesarios de animación
var is_near_object: bool = false

# Controla si la transición debe continuar con "idle_feliz"
var transitioning_to_happy: bool = false

# Indica si la burbuja está "muerta"
var is_dead: bool = false

func _ready():
	# Configura la animación inicial (idle_triste o similar)
	animated_sprite_2d.play("idle_triste")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and not is_dead:
		# Si es el primer clic, reproduce la transición de triste a feliz
		if not has_clicked:
			has_clicked = true
			transitioning_to_happy = true
			animated_sprite_2d.speed_scale = -1.0  # Reproducción normal
			animated_sprite_2d.play("trans_feliz_triste")

		# Obtiene la dirección desde la posición del mouse
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()

		# Aplica el impulso en la dirección calculada
		apply_impulse(direction * impulse_strength)

# Llamado cuando la burbuja se acerca a un objeto
func _on_fear_body_entered(body: Node2D) -> void:
	if not is_near_object and not is_dead:  # Solo cambiar si no está ya cerca y no está muerta
		is_near_object = true
		animated_sprite_2d.speed_scale = 1.0  # Reproducción normal
		animated_sprite_2d.play("trans_feliz_triste")

# Llamado cuando la burbuja se aleja de un objeto
func _on_fear_body_exited(body: Node2D) -> void:
	if is_near_object and not is_dead:  # Solo cambiar si estaba cerca y no está muerta
		is_near_object = false
		animated_sprite_2d.speed_scale = -1.0  # Reproducción inversa
		animated_sprite_2d.play("trans_feliz_triste")
		# Asegura que la animación comience desde el final
		animated_sprite_2d.frame = animated_sprite_2d.sprite_frames.get_frame_count("trans_feliz_triste") - 1

# Llamado cuando termina cualquier animación
func _on_animated_sprite_2d_animation_finished() -> void:
	if is_dead:
		queue_free()  # Elimina la burbuja al terminar la animación de muerte
	elif transitioning_to_happy:
		transitioning_to_happy = false
		animated_sprite_2d.play("idle_feliz")
	elif is_near_object:
		animated_sprite_2d.speed_scale = 1.0  # Aseguramos velocidad normal
		animated_sprite_2d.play("idle_triste")
	else:
		animated_sprite_2d.speed_scale = 1.0  # Aseguramos velocidad normal
		animated_sprite_2d.play("idle_feliz")

# Llamado cuando la burbuja colisiona con algo
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemy") and not is_dead:  # Solo si no está ya muerta
		is_dead = true  # Marca la burbuja como "muerta"
		animated_sprite_2d.play("idle_dead")  # Reproduce la animación de muerte
