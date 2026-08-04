extends Control
@onready var dead_label: Label = $dead_label
@onready var breathingbar: ProgressBar = $breathingbar
@onready var closed_eyes: ColorRect = $closed_eyes
@onready var BPM_Label : Label = %Heart_Rate
@onready var Audio : Variant
@onready var AudioPlayer : Variant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.Breath_count = 100
	breathingbar.max_value = 100
	breathingbar.value = GameManager.Breath_count # Replace with function body.
	closed_eyes.color.a = 0.0
	GameManager.UI = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	BPM_Label.text = str(GameManager.Heart_Rate)
	breathingbar.value = GameManager.Breath_count
	if Input.is_action_pressed("hold_breath") and GameManager.Breath_count > 0:
		GameManager.Is_Breathing = false
		print("not breathing")
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
