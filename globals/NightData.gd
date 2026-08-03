extends Node

var AI: Dictionary = {
	"Night_1": {
		"DoorMan": 20,
		"WindowMan": 0,
		"FeetLover": 0,
	}
}

var DoorMan_AI: int = 0
var WindowMan_AI: int = 0
var FeetLover_AI: int = 0


func _Update_AI() -> void:
	var current_night_key: String = "Night_" + str(GameManager.Night)
	
	if AI.has(current_night_key):
		var night_data: Dictionary = AI[current_night_key]
		DoorMan_AI = night_data.get("DoorMan", 0)
		WindowMan_AI = night_data.get("WindowMan", 0)
		FeetLover_AI = night_data.get("FeetLover", 0)
	else:
		push_warning("No AI configuration found for: " + current_night_key)
