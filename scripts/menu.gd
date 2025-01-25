extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/opciones.tscn")


func _on_salir_pressed() -> void:
	get_tree().quit()
