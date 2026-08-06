extends Node

var TryCount = 0

func _ready() -> void:
	GameManager.AttackCount = 0
	GameManager.Heart_Rate = 84
	print("u here?")
	await get_tree().create_timer(5.0).timeout
	if TryCount == 0:
		get_tree().change_scene_to_file("res://scenes/Intermission/intermission_minigame.tscn")
	else:
		TryCount += 1
		get_tree().change_scene_to_file("res://scenes/Game_Scene/main_game.tscn")
		print("did ya get ported?")
		
	
