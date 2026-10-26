extends Node2D
signal my_signal
@export var _rotation_speed: float = TAU * 2
var swung = false
var mouseangle = 0
var counter = 0 
var mousepos = Vector2(0,0)
@onready var player = get_node("/root/Garden/Player")
var oncooldown = false
var beyblade = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sceneName = get_tree().get_current_scene().name
	player = get_node("/root/" + sceneName + "/Player")
	if Global.doubleinvincibility:
		$Invincibility.wait_time *= 2
	if Global.nocooldown:
		$cooldown.wait_time = 0
	if Global.beyblade:
		Global.beyblade = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed('Beyblade')):
		Global.beyblade = true
		print("beyblade")
	if (Global.beyblade):
		Global.startpos = $playerpivot.position
		$Area2D.monitorable = true
		mouseangle = 60
		rotate(mouseangle / 16)
		#my_signal.emit()
		player.invincible = true	
		if (Input.is_action_just_pressed('stop')):
			Global.beyblade = false
	if (Input.is_action_just_pressed('swing') and !swung and !oncooldown) or (Input.is_action_just_pressed('swing') and Global.nocooldown):
		Global.startpos = $playerpivot.position
		$Area2D.monitorable = true
		mouseangle = get_angle_to(get_global_mouse_position())
		print(mouseangle)
		if abs(rad_to_deg(mouseangle)) < 60 and Global.anglethreshold:
			mouseangle = deg_to_rad(60) * (-1 if mouseangle < 0 else 1)
		swung = true
		player.invincible = true
		$Invincibility.start()
		$Timer.start()
		
		
		
	if (swung and counter < 16):
		counter += 1
		rotate(mouseangle / 16)
		if counter >=8:
			if !Global.strongman:
				my_signal.emit()
	if(counter >= 16):
		$Timer.stop()
		$Timer.timeout.emit()



func _on_timer_timeout() -> void:
	oncooldown = true
	$cooldown.start()
	swung = false
	counter=0
	$Area2D.monitorable = false


func _on_invincibility_timeout() -> void:
	player.invincible = false


func _on_cooldown_timeout() -> void:
	oncooldown = false
