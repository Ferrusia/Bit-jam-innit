extends Node3D

var Speed : float = 0.01
var Origin : Vector3 = global_position
var Dir : int = 1
var AI : int = 0

func _process(delta: float) -> void:
	AI = NightData.FeetLover_AI
	position.y += Speed * AI * delta * Dir# TODO : FIX TS
	if Input.is_action_pressed("Breathe"):
		Dir = -1.25
	else:
		Dir = 1.25
	if global_position.y >= 1.5:
		global_position = Origin
		GameManager.Attack_Player("Feet_Tickler", 25)
		GameManager.PSFX(preload("res://sound_library/Minecraft cave noises 4.mp3"))
