extends CharacterBody2D
var speed : int = 1000
var direction : Vector2
var shot = false

@onready var path = get_node("/root/Garden/Boss/Path2D/PathFollow2D")
func _physics_process(delta):
	look_at($"/root/Garden/Boss".position)
	if (not shot):
		direction = (path.position - position)
		shot = true
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
