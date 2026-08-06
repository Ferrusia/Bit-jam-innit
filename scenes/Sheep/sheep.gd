extends Sprite2D

var Speed : int = randi_range(100, 200)

func _ready() -> void:
	position.y = randi_range(-500, 500)

func _process(delta: float) -> void:
	position.x -= Speed * delta
	
