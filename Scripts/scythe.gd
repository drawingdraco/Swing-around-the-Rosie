extends Node2D
signal my_signal
@export var _rotation_speed: float = TAU * 2
var swung = false
var mouseangle = 0
var counter = 0 
var mousepos = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed('swing') and !swung):
		Global.startpos = $playerpivot.position
		$Area2D.monitorable = true
		mouseangle = get_angle_to(get_global_mouse_position())
		print(mouseangle)
		if abs(rad_to_deg(mouseangle)) < 60:
			mouseangle = deg_to_rad(60) * (-1 if mouseangle < 0 else 1)
		swung = true
		$Timer.start()
		
		
	if (swung and counter < 16):
		counter += 1
		rotate(mouseangle / 16)
		if counter >=8:
			my_signal.emit()
	if(counter >= 16):
		$Timer.stop()
		$Timer.timeout.emit()



func _on_timer_timeout() -> void:
	swung = false
	counter=0
	$Area2D.monitorable = false
