extends Node

var AI: Dictionary = {
	"Night_1": {
		"DoorMan": 20,
		"WindowWoman": 20,
		"Vent_Enemy": 20,
		"FeetLover": 0,
	},
	"Night_2": {
		"DoorMan": 7,
		"WindowWoman": 5,
		"Vent_Enemy": 0,
		"FeetLover": 0,
	}
}

var DoorMan_AI: int = 0
var WindowWoman_AI: int = 0
var FeetLover_AI: int = 0
var Vent_Enemy_AI: int = 0

var AttacksPerNight: Array = [5, 10, 15, 20, 25]






func _Update_AI() -> void:
	var current_night_key: String = "Night_" + str(GameManager.Night)
	
	if AI.has(current_night_key):
		var night_data: Dictionary = AI[current_night_key]
		DoorMan_AI = night_data.get("DoorMan", 0)
		WindowWoman_AI = night_data.get("WindowWoman", 0)
		FeetLover_AI = night_data.get("FeetLover", 0)
		Vent_Enemy_AI = night_data.get("Vent_Enemy", 0)
	else:
		push_warning("No AI configuration found for: " + current_night_key)
		
		
func	_win():
	GameManager.Night += 1
	
