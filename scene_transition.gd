extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func change_scene(target: String) -> void:
	
	print("Iniciando transición de escena...")
	animation_player.play("disolve")
	await animation_player.animation_finished 
	get_tree().change_scene_to_file(target)
	animation_player.play_backwards("disolve")
	
 
