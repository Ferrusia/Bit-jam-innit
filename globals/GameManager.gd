extends Node

var UI: Node = null
var door_enemy_sfx = null

var AttackCount: int = 0

var Breath_count : float = 100
var Is_Breathing : bool = false

var Night : int = 1
var SleepyCount : int = 0
var Is_Playing : bool = true

var Is_Dead : bool = false

var Heart_Rate : int = 84 #in BPM btw, 220 kills u

var Is_Sleeping : bool = false
var Deaths : int = 0

@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	Heart_Bound()
	if Heart_Rate > 220:
		death()
		GameManager.Deaths += 1
		SaveManager.save_game(SaveManager.Data)
		
func PSFX(stream: AudioStream):
	var asp = AudioStreamPlayer.new()
	add_child(asp)
	asp.stream = stream
	asp.finished.connect(asp.queue_free) # Delete the node when done
	asp.play()

@warning_ignore("unused_parameter")
func Attack_Player(Name : String, BPM : int) -> void:
	print("Heart Rate : " + str(Heart_Rate))
	Heart_Rate += BPM
	
	
	
func death():
	UI.dead_label.text = "u dead :sob:"
	UI.get_node("returnmainmenu").visible = true
	AttackCount = 0
	GameManager.Is_Dead = true
	
func Heart_Bound() -> void:
	if Heart_Rate < 84:
		Heart_Rate = 84
	

	
	
	
