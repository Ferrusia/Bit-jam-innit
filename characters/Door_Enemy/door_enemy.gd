extends Node3D

@onready var Audio : Variant

var AI : int = NightData.DoorMan_AI
enum Location {
	Not_Yet,
	Hall_End,
	Door_Way,
	Bed_Side,
	Attack
}

func _ready() -> void:
	NightData._Update_AI()
		
var Current_Position : int = Location.Not_Yet
var CoolDown_Count : float = 1
var CoolDown_Timer : float = CoolDown_Count

@onready var Preset_Loation : = [
	null,
	%Pos_1,
	%Pos_2,
	%Pos_3,
	null,
]

func _Movement(delta) -> void:
	CoolDown_Timer -= delta
	if CoolDown_Timer < 0:
		CoolDown_Timer = CoolDown_Count
		var SemiHemiFifth_Chance = randi_range(1, 20) 
		
		if SemiHemiFifth_Chance <= NightData.DoorMan_AI:
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
		if Evade_Timer < 0  and not Input.is_action_pressed("close_eyes"):
			Evade_Timer = Evade_Count
			print("boo")
			Audio = preload("res://sound_library/jumpscare sound.mp3")
			GameManager.PSFX(Audio)
			GameManager.death()
			GameManager.Attack_Player("DoorMan", 25)
			RESET()
		elif Evade_Timer < 0  and Input.is_action_pressed("close_eyes"):
			print("Test")
			Audio = preload("res://sound_library/Minecraft cave noises 4.mp3")
			GameManager.PSFX(Audio)
			GameManager.AttackCount += 1
			GameManager.UI.UI_update()
			RESET()
	
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
	if Current_Position < Location.Bed_Side:
		_Movement(delta)
	else:
		print("p")
		_ATTACK(delta)
				
func RESET() -> void:
	Current_Position = Location.Not_Yet
	CoolDown_Timer = CoolDown_Count
	Evade_Timer = Evade_Count
	Sleep_Timer = Sleep_Count
		
