extends Node3D

@onready var Audio : Variant


var AI : int = NightData.WindowWoman_AI
enum Location {
	Not_Yet,
	small_peek,
	big_peek,
	wholeway,
	Attack
}

func _ready() -> void:
	NightData._Update_AI()
	LongWait()
		
var Current_Position : int = Location.Not_Yet
var CoolDown_Count : float = 2*3.14
var CoolDown_Timer : float = CoolDown_Count

@onready var Preset_Loation : = [
	null,
	%wwPos_1,
	%wwPos_2,
	%wwPos_3,
	null]



var go: bool = false


var longwait: float
func LongWait():
	longwait = randf_range(0,20)
	await get_tree().create_timer(longwait).timeout
	go = true
	print("go =" + str(go))
	
	


func _Movement(delta) -> void:
	if go == false:
		return
	else:
		CoolDown_Timer -= delta
		if CoolDown_Timer < 0:
			CoolDown_Timer = CoolDown_Count
			var SemiHemiFifth_Chance = randi_range(1, 20) 
		
			if SemiHemiFifth_Chance <= NightData.WindowWoman_AI:
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

var Evade_Count : float = 5
var Evade_Timer : float = Evade_Count
var Sleep_Count : float = 1
var Sleep_Timer : float = Sleep_Count

func _ATTACK(delta) -> void:
	if Input.is_action_pressed("hold_breath") and %View.Current_View == %View.View_Points.Left:
		Sleep_Timer -= delta
		if Sleep_Timer < 0:
			Sleep_Timer = Sleep_Count
			RESET()
			Audio = preload("res://sound_library/Minecraft cave noises 4.mp3")
			GameManager.PSFX(Audio)
			GameManager.AttackCount += 1
	else:
		Evade_Timer -= delta
		if Evade_Timer < 0:
			Evade_Timer = Evade_Count
			Audio = preload("res://sound_library/jumpscare sound.mp3")
			GameManager.PSFX(Audio)
			GameManager.Attack_Player("WindowWoman", 35)
			RESET()
			GameManager.UI.idletimer = 5.0
			
func _process(delta: float) -> void:
	_Displayer()
	if Current_Position < Location.wholeway:
		_Movement(delta)
	else:
		_ATTACK(delta)
				
func RESET() -> void:
	Current_Position = Location.Not_Yet
	Evade_Timer = Evade_Count
	Sleep_Timer = Sleep_Count
	go = false
	LongWait()
		
