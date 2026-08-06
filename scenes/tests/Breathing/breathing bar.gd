extends Control
@onready var dead_label: Label = $dead_label
@onready var breathingbar: ProgressBar = $breathingbar
@onready var closed_eyes: ColorRect = $closed_eyes
@onready var BPM_Label : Label = %Heart_Rate
@onready var Audio : Variant
@onready var AudioPlayer : Variant
var Interval : float = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.Breath_count = 100
	breathingbar.max_value = 100
	breathingbar.value = GameManager.Breath_count # Replace with function body.
	closed_eyes.color.a = 0.0
	GameManager.UI = self
	$NightNumber.text = "Night " + str(GameManager.Night)
	$DebugLabel.text = str(GameManager.AttackCount) + " times evaded death" 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	UI_update()
	BPM_Label.text = str(GameManager.Heart_Rate)
	breathingbar.value = GameManager.Breath_count
	if Input.is_action_pressed("hold_breath") and GameManager.Breath_count > 0:
		GameManager.Is_Breathing = false
		GameManager.Breath_count -= 30 * delta	
		if AudioPlayer == null:
			AudioPlayer = AudioStreamPlayer.new()
			AudioPlayer.stream = preload("res://sound_library/Atem anhalten struggle.mp3")
			add_child(AudioPlayer)
			AudioPlayer.play()
	else:
		GameManager.Is_Breathing = true
		if AudioPlayer != null:
			AudioPlayer.stop()
			AudioPlayer.queue_free()
			AudioPlayer == null
		
	
		
		
	if GameManager.Breath_count < 100:
		GameManager.Breath_count += 15 * delta


	if Input.is_action_pressed("close_eyes"):
		Interval -= get_process_delta_time()
		if Interval <= 0:
			Interval = 1
			GameManager.Heart_Rate -= 1
		GameManager.Is_Sleeping = true
		closed_eyes.color.a = 100.0
	else:
		GameManager.Is_Sleeping = false
		closed_eyes.color.a = 0.0
		
	if GameManager.Breath_count <= 0:
		GameManager.death()

	if Input.is_action_just_released("hold_breath") and breathingbar.value > 66 :
		Audio = preload("res://sound_library/luft holen nach ersticken 3.mp3")
		GameManager.PSFX(Audio)
	elif Input.is_action_just_released("hold_breath") and breathingbar.value > 33:
		Audio = preload("res://sound_library/luft holen nach ersticken 1.mp3")
		GameManager.PSFX(Audio)
	elif Input.is_action_just_released("hold_breath") and breathingbar.value > 0:
		Audio = preload("res://sound_library/luft holen nach ersticken 2.mp3")
		GameManager.PSFX(Audio)
	

func _on_returnmainmenu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Main_Menu/menu.tscn")
	pass # Replace with function body.

var Sleeping : float = 0
func UI_update():
	$NightNumber.text = "Night " + str(GameManager.Night)
	
	if GameManager.AttackCount >= NightData.AttacksPerNight[GameManager.Night-1]:
		%DebugLabel.text = "You can Sleep Now"
		if Input.is_action_pressed("close_eyes"):
			Sleeping += get_process_delta_time()
			if Sleeping >= 2:
				GameManager.Night += 1
				GameManager.AttackCount = 0
				GameManager.Heart_Rate = 84
				get_tree().change_scene_to_file("res://scenes/Intermission/intermission_minigame.tscn")
		else:
			Sleeping = 0
		
	else:
		$DebugLabel.text = str(GameManager.AttackCount) + " times evaded death"
	
