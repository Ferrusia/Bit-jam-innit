extends Control
@onready var dead_label: Label = $dead_label
@onready var breathingbar: ProgressBar = $breathingbar
var breath: float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	breathingbar.max_value = 100
	breathingbar.value = breath # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	breathingbar.value = breath
	if Input.is_action_pressed("ui_accept") and breath > 0:
		breath -= 30 * delta	
			
	elif breath < 100:
		breath += 1 * delta
		
	if breath <= 0:
		dead_label.text = "u dead :sob:"
