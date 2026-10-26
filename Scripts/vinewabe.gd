extends CharacterBody2D

var move = false

@onready var warning = get_node("/root/Garden/Camera2D/Warning")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var sceneName = get_tree().get_current_scene().name
	if (sceneName != "Garden"):
		print("Not in Garden")
	else:
		warning.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (move):
		#moves straight down towards the player
		velocity = Vector2(0,1) * 400
		move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()


func _on_timer_2_timeout() -> void:
	warning.visible = false
	move = true
	$Timer.start()
