extends Control
#
func _on_play_pressed() -> void:
	SceneTransition.change_scene("res://scenes/intro.tscn")
	print("este boton funciona")


func _on_salir_pressed() -> void:
	get_tree().quit()
