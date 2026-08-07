extends Control

func _ready() -> void:
	GameManager.Heart_Rate = 84

func _process(delta) -> void:
	%ContinueNight.text = "Night : " + str(int(SaveManager.Load_Data().get("Night")))
	
func Play() -> void:
	get_tree().change_scene_to_file("res://scenes/Game_Scene/main_game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	SaveManager.Reset_Game()
	Play()

func _on_continue_pressed() -> void:
	SaveManager.Load_Game()
	Play()
