extends CharacterBody2D

var move = false

@onready var warningtop = get_node("/root/Garden/Camera2D/Warningtop")
@onready var warningbottom = get_node("/root/Garden/Camera2D/Warningbottom")
@onready var warningleft = get_node("/root/Garden/Camera2D/Warningleft")
@onready var warningright = get_node("/root/Garden/Camera2D/Warningright")
var top = false
var bottom = false
var left = false
var right = false
@export var rotate = 90
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sceneName = get_tree().get_current_scene().name
	if (sceneName != "Garden"):
		print("Not in Garden")
	else:	
		if abs(position.x) > abs(position.y):
			if (position.x < 0):
				left = true
				scale = Vector2(.5, 1)
				warningleft.visible = true
				$Timer.wait_time = 4
			else:
				scale = Vector2(.5, 1)
				right = true
				warningright.visible = true
				$Timer.wait_time = 4
		else:
			if (position.y < 0):
				top = true
				rotation = 0
				warningtop.visible = true
			else:
				bottom = true
				rotation = 0
				warningbottom.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (move and top):
		#moves straight down towards the player
		velocity = Vector2(0,1) * 400
		move_and_slide()
	elif (move and bottom):
		#moves straight up towards the player
		velocity = Vector2(0,-1) * 400

		move_and_slide()
	elif (move and left):
		#moves straight right towards the player
		velocity = Vector2(1,0) * 400
		
		move_and_slide()
	elif (move and right):
		#moves straight left towards the player
		velocity = Vector2(-1,0) * 400
		
		move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_timer_2_timeout() -> void:
	warningtop.visible = false
	warningbottom.visible = false
	warningleft.visible = false
	warningright.visible = false

	move = true
	$Timer.start()
