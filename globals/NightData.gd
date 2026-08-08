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
		"Vent_Enemy": 6,
		"FeetLover": 0,
	},
	"Night_3": {
		"DoorMan": 12,
		"WindowWoman": 10,
		"Vent_Enemy": 9,
		"FeetLover": 5,
	},
	"Night_4": {
		"DoorMan": 15,
		"WindowWoman": 14,
		"Vent_Enemy": 13,
		"FeetLover": 10,
	},
	"Night_5": {
		"DoorMan": 19,
		"WindowWoman": 20,
		"Vent_Enemy": 17,
		"FeetLover": 15,
	},
	"Night_6": {
		"DoorMan": 20,
		"WindowWoman": 20,
		"Vent_Enemy": 20,
		"FeetLover": 20,
	},
}

var DoorMan_AI: int = 0
var WindowWoman_AI: int = 0
var FeetLover_AI: int = 0
var Vent_Enemy_AI: int = 0

var AttacksPerNight: Array = [5, 10, 15, 20, 25, 40, 9999999]
	
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
		
		

		
