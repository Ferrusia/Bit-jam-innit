extends Node2D

@onready var Sheep = preload("res://scenes/Sheep/sheep.tscn")
var Intermission : float = 0
func _process(delta: float) -> void:
	Intermission += delta
	if Intermission >= 0.25 and $"..".Minigame_Timer > 5:
		Intermission = 0
		var Chance = randi_range((GameManager.Night - 1) * 2, 11)
		if Chance == 10:
			$"..".True_Sheep_Count += 1
			var i = Sheep.instantiate()
			add_child(i)
			
		
