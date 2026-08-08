extends Node

const SAVE_PATH := "user://savegame.json"

# Saving data
var Original_Data : = {
		"Night" : 1,
		"Deaths" : 0
	}

var Data
func _process(delta: float) -> void:
	Data = {
		"Night" : GameManager.Night,
		"Deaths" : GameManager.Deaths
	}

func Load_Game() -> void:
	var SAVEDATA := Load_Data()
	if not SAVEDATA.is_empty():
		GameManager.Night = SAVEDATA.get("Night")
		GameManager.Deaths = SAVEDATA.get("Deaths")
		
func Reset_Game() -> Dictionary:
	var reset_data := Original_Data.duplicate(true)
	print("Duplicate Data : " + str(reset_data))
	save_game(reset_data)
	return reset_data
	
# Save a dictionary of game data to JSON
func save_game(data: Dictionary) -> void:
	var json_string := JSON.stringify(data, "\t")
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	else:
		push_error("Failed to open file for writing: ", FileAccess.get_open_error())

# Load and return the dictionary from JSON
func Load_Data() -> Dictionary:
	if not FileAccess.file_exists(SAVE_PATH):
		print("Save file does not exist.")
		return {}

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		push_error("Failed to open file for reading: ", FileAccess.get_open_error())
		return {}

	var json_string := file.get_as_text()
	file.close()

	var json := JSON.new()
	var error := json.parse(json_string)
	if error == OK:
		var data = json.get_data()
		if data is Dictionary:
			
			return data
	
	push_error("JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
	return {}
