extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "bud"
	monitorable = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
	


func _on_timer_2_timeout() -> void:
	$AnimatedSprite2D.animation = "default"
	monitorable = true
	$Timer.start()
