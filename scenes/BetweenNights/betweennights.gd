extends Node

func _ready() -> void:
	GameManager.Heart_Rate = 84
	print("u here?")
	await get_tree().create_timer(10.0).timeout
	get_tree().change_scene_to_file("res://scenes/Game_Scene/main_game.tscn")
	print("did ya get ported?")
