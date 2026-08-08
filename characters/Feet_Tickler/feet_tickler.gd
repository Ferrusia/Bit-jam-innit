extends Node3D

var Speed : float = 0.01
var Origin : Vector3 = global_position
var Dir : int = 1
var AI : int = 0


var go: bool = false

var longwait: float
func LongWait():
	longwait = randf_range(0,20)
	await get_tree().create_timer(longwait).timeout
	go = true
	
	
func _ready():
	LongWait()

func _process(delta: float) -> void:
	if go == false:
		return
	else:

		AI = NightData.FeetLover_AI
		position.y += Speed * AI * delta * Dir# TODO : FIX TS
		
		if Input.is_action_pressed("Breathe"):
			Dir = -1.25
		else:
			Dir = 1.25
			
		if global_position.y >= 1.5:
			global_position = Origin
			GameManager.Attack_Player("Feet_Tickler", 25)
			GameManager.PSFX(preload("res://sound_library/jumpscare sound.mp3"))
			GameManager.UI.idletimer = 5.0
			go = false
			LongWait()
			
	
			
