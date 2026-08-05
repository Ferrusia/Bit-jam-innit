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
var CoolDown_Count : float = 1
var CoolDown_Timer : float = CoolDown_Count

@onready var Preset_Loation : = [
	null,
	%vePos_1,
	%vePos_2,
	%vePos_3,
	null]

func _Movement(delta) -> void:
	CoolDown_Timer -= delta/2
	if CoolDown_Timer < 0:
		CoolDown_Timer = CoolDown_Count
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
	if not GameManager.Is_Sleeping:
		Evade_Timer -= delta
		if Evade_Timer < 0  and GameManager.Is_Breathing == true:
			Evade_Timer = Evade_Count
			Audio = preload("res://sound_library/jumpscare sound.mp3")
			GameManager.PSFX(Audio)
			GameManager.death()
			print("boo")
			GameManager.Attack_Player("Vent_Enemy", 25)
			RESET()
		elif Evade_Timer < 0  and GameManager.Is_Breathing == false:
			RESET()
			Audio = preload("res://sound_library/Minecraft cave noises 4.mp3")
			GameManager.PSFX(Audio)
	
		
		
	else:
		Sleep_Timer -= delta
		if Sleep_Timer < 0:
			Sleep_Timer = Sleep_Count
			RESET()
			Audio = preload("res://sound_library/Minecraft cave noises 4.mp3")
			GameManager.PSFX(Audio)
			GameManager.AttackCount += 1
			GameManager.UI.UI_update()
			
func _process(delta: float) -> void:
	_Displayer()
	if Current_Position < Location.peeking_out:
		_Movement(delta)
	else:
		print("p")
		_ATTACK(delta)
				
func RESET() -> void:
	Current_Position = Location.Not_Yet
	Evade_Timer = Evade_Count
	Sleep_Timer = Sleep_Count
		
