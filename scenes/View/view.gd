extends Camera3D

enum View_Points{
	Left,
	Front,
	Right,
}

var Current_View : int = View_Points.Front
var Prev_View : int = 67
func _process(delta: float) -> void:
	View_Logic(delta)
	Transition()

func Transition() -> void:
	if Current_View != Prev_View:
		match Current_View:
			View_Points.Left:
				%View_Anim.play("Left_Face")
			View_Points.Front:
				match Prev_View:
					0:
						%View_Anim.play_backwards("Left_Face")
					2:
						%View_Anim.play_backwards("Right_Face")
			View_Points.Right:
				%View_Anim.play("Right_Face")
		Prev_View = Current_View
	else:
		pass
	
var CoolDown_Bound : float = 0.25
var CoolDown_Timer : float = CoolDown_Bound

func View_Logic(delta) -> void:
	CoolDown_Timer -= delta
	if CoolDown_Timer < 0:
		if Input.is_action_just_pressed("Left"):
			Current_View -= 1
			CoolDown_Timer = CoolDown_Bound
		if Input.is_action_just_pressed("Right"):
			Current_View += 1
			CoolDown_Timer = CoolDown_Bound
			
		if Current_View < 0:
			Current_View = 0
		if Current_View > 2:
			Current_View = 2
		
