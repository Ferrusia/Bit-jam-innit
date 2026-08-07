extends Node2D

var True_Sheep_Count : int = 0

var Sheep_Count : int = 0
var Minigame_Timer : float = 45
func _process(delta: float) -> void:
	%Sheep_Count.text = str(Sheep_Count)
	Minigame_Timer -= delta
	%Time_Left.text = str(int(Minigame_Timer))
	if Input.is_action_just_pressed("Count_Sheep"):
		Sheep_Count += 1
	if Minigame_Timer < 0:
		CHECK()
		get_tree().change_scene_to_file("res://scenes/Game_Scene/main_game.tscn")
	if Input.is_action_just_pressed("Forward"):
		Minigame_Timer = 2
		
func CHECK() -> void:
	if True_Sheep_Count == Sheep_Count:
		GameManager.AttackCount += 5
