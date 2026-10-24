extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#moves straight down towards the player
	velocity = Vector2(0,1) * 600
	move_and_slide()


func _on_timer_timeout() -> void:
	queue_free()
