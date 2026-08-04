extends Control
@onready var dead_label: Label = $dead_label
@onready var breathingbar: ProgressBar = $breathingbar
@onready var closed_eyes: ColorRect = $closed_eyes
@onready var BPM_Label : Label = %Heart_Rate


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.Breath_count = 100
	breathingbar.max_value = 100
	breathingbar.value = GameManager.Breath_count # Replace with function body.
	closed_eyes.color.a = 0.0
	GameManager.ui = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	BPM_Label.text = str(GameManager.Heart_Rate)
	breathingbar.value = GameManager.Breath_count
	if Input.is_action_pressed("Breathe") and GameManager.Breath_count > 0:
		GameManager.Is_Breathing = true
		GameManager.Breath_count -= 30 * delta	
	else:
		GameManager.Is_Breathing = false
		
	if GameManager.Breath_count < 100:
		GameManager.Breath_count += 15 * delta
		
	if Input.is_action_pressed("close_eyes"):
		GameManager.Is_Sleeping = true
		closed_eyes.color.a = 100.0
	else:
		GameManager.Is_Sleeping = false
		closed_eyes.color.a = 0.0
		
	if GameManager.Breath_count <= 0:
		dead_label.text = "u dead :sob:"
