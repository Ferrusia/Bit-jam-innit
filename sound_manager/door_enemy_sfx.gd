extends Node3D

@export var Footsteps:  Array[AudioStream] = [
preload("res://sound_library/Footsteps 1.mp3"), 
preload("res://sound_library/Footsteps 2.mp3"), 
preload("res://sound_library/Footsteps 3.mp3"), 
preload("res://sound_library/Footsteps 4.mp3"), 
preload("res://sound_library/Footsteps 5 mit speed up.mp3")
]

func _PlaySFX() -> void:
	var Fifth_Chance : int = randi_range(0, 4) 
	GameManager.PSFX(Footsteps[Fifth_Chance])
	
