extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer




func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	SceneTransition.change_scene("res://scenes/escenario.tscn")
