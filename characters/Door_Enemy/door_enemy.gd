extends Node3D

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
	%Pos_3
]

func _Movement(delta) -> void:
	CoolDown_Timer -= delta
	if CoolDown_Timer < 0:
		CoolDown_Timer = CoolDown_Count
		var SemiHemiFifth_Chance = randi_range(1, 20) 
		
		if SemiHemiFifth_Chance <= NightData.DoorMan_AI:
			Current_Position += 1

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
		if Evade_Timer < 0:
			Evade_Timer = Evade_Count
			print("boo")
			GameManager.Attack_Player("DoorMan", 25)
			RESET()
	
	else:
		Sleep_Timer -= delta
		if Sleep_Timer < 0:
			Sleep_Timer = Sleep_Count
			RESET()
			
func _process(delta: float) -> void:
	_Displayer()
	if Current_Position < Location.Bed_Side:
		_Movement(delta)
	else:
		print("p")
		_ATTACK(delta)
				
func RESET() -> void:
	Current_Position = Location.Not_Yet
	Evade_Timer = Evade_Count
	Sleep_Timer = Sleep_Count
		
