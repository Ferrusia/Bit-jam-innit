extends Camera3D

enum View_Points{
	Left,
	Front,
	Right,
}

var Current_View : int = View_Points.Front

func _process(delta: float) -> void:
	View_Logic()
	
	

func View_Logic() -> void:
	if Input.is_action_just_pressed("Left"):
		Current_View += 1
	if Input.is_action_just_pressed("Right"):
		Current_View -= 1
		
	if Current_View < 0:
		Current_View = 0
	if Current_View > 2:
		Current_View = 2
		
