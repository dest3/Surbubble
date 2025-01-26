extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	print_tree()
	if not animation_player:
		push_error("AnimationPlayer no encontrado.")

	if not animation_player:
		push_error("AnimationPlayer no encontrado en la escena autoload.")
		return

func change_scene(target: String) -> void:
	if animation_player:
		print("Iniciando transición de escena...")
		animation_player.play("disolve")
		await animation_player.animation_finished
		get_tree().change_scene_to_file(target)
		animation_player.play_backwards("disolve")
	else:
		push_error("AnimationPlayer no está disponible.")
