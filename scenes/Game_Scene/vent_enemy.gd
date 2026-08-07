extends Node3D

@onready var Audio : Variant

var AI : int = NightData.Vent_Enemy_AI
enum Location {
	Not_Yet,
	farfarback,
	farback,
	peeking_out,
	Attack
}

func _ready() -> void:
	NightData._Update_AI()
		
var Current_Position : int = Location.Not_Yet

@onready var Preset_Loation : = [
	null,
	%vePos_1,
	%vePos_2,
	%vePos_3,
	null
	]

func _Movement(delta) -> void:
	var SemiHemiFifth_Chance = randi_range(1, 20) 
	if SemiHemiFifth_Chance <= NightData.Vent_Enemy_AI:
		Current_Position += 1
		GameManager.door_enemy_sfx._PlayFootstepSFX()

func _Displayer() -> void:
	if GameManager.Is_Playing:
		for i in range(Preset_Loation.size()):
			if Preset_Loation[i] != null:
				if i != Current_Position:
					Preset_Loation[i].visible = false
				else:
					Preset_Loation[i].visible = true			
			else:
				pass

var Evade_Count : float = 2
var Evade_Timer : float = Evade_Count
var Sleep_Count : float = 1
var Sleep_Timer : float = Sleep_Count

func _ATTACK(delta) -> void:
	Audio = preload("res://sound_library/jumpscare sound.mp3")
	GameManager.PSFX(Audio)
	GameManager.Attack_Player("Vent_Enemy", 50)
	RESET()
			
			
func _process(delta: float) -> void:
	_Displayer()
	if not Current_Position < Location.Attack:
		_ATTACK(delta)
		
				
func RESET() -> void:
	Current_Position = Location.Not_Yet
	Evade_Timer = Evade_Count
	Sleep_Timer = Sleep_Count
		
