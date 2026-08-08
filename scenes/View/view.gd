extends Camera3D

enum View_Points{
	Left,
	Front,
	Right,
}

var Current_View : int = View_Points.Front
var Prev_View : int = 67

func _ready() -> void:
	GameManager.Is_Sleeping = false

func _process(delta: float) -> void:
	if not GameManager.Is_Dead:
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
						%Vent_Enemy._Movement(67)
					2:
						%View_Anim.play_backwards("Right_Face")
						%Vent_Enemy._Movement(67)
				
			View_Points.Right:
				%View_Anim.play("Right_Face")
		Prev_View = Current_View
		GameManager.Heart_Rate += randi_range(1, 3)
	else:
		pass
	
var CoolDown_Bound : float = 0.2
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
		
