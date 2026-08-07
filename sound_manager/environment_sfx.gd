extends Node3D

@onready var Audio : = preload("res://sound_library/Heartratemonitor.mp3")

var Beep_Timer : float = 0
 
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Backwards"):
		%UI._BeatNight()
	
	if not GameManager.Is_Dead:
		var Beep_Interval = (60.00 / GameManager.Heart_Rate) 
		Beep_Timer += delta
		if Beep_Timer > Beep_Interval:
			Beep_Timer -= Beep_Interval
			GameManager.PSFX(Audio) 
	else:
		pass
