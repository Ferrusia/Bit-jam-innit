extends Node3D

var Speed : float = 100
var Origin : Vector3 = global_position
func _process(delta: float) -> void:
	position.y -= Speed * delta # TODO : FIX TS
