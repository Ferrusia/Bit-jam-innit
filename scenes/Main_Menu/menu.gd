extends Control

func _ready() -> void:
	GameManager.Heart_Rate = 84

func _process(delta) -> void:
	if int(SaveManager.Load_Data().get("Night")) < 6:
		%ContinueNight.text = "Night : " + str(int(SaveManager.Load_Data().get("Night")))
	else:
		%ContinueNight.text = "Night : 6"
		
func Play() -> void:
	get_tree().change_scene_to_file("res://scenes/Game_Scene/main_game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	SaveManager.Reset_Game()
	GameManager.Night = 1
	GameManager.Deaths = 0
	Play()

func _on_continue_pressed() -> void:
	SaveManager.Load_Game()
	if int(SaveManager.Load_Data().get("Night")) > 5:
		GameManager.Night = 6
	Play()
