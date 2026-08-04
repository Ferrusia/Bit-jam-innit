"""
class_name SoundManager
extends Node
@export var footsteps:  Array[AudioStream] = [
preload("res://sound_library/Footsteps 1.mp3"), 
preload("res://sound_library/Footsteps 2.mp3"), 
preload("res://sound_library/Footsteps 3.mp3"), 
preload("res://sound_library/Footsteps 4.mp3"), 
preload("res://sound_library/Footsteps 5 mit speed up.mp3")
]

func footsteps_play(target_node: Variant):
	if target_node is AudioStreamPlayer3D:
		target_node.stream = footsteps.pick_random()
		target_node.play()
	elif target_node is AudioStream:
		target_node.stream = footsteps.pick_random()	
		target_node.play()


func holdingbreath_play(target_node: AudioStream):
	if target_node == AudioStreamPlayer3D:
		var stream = footsteps.pick_random()
		GameManager.PSFX(stream)
	elif target_node == AudioStream:
		GameManager.PSFX(stream)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

"""
