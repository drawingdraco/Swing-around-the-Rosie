extends CharacterBody2D

var speed : int = 500
var direction : Vector2
var shot = false
@onready var main = get_node("/root/Garden")
@onready var player = get_node("/root/Garden/Player")
func _physics_process(delta):
	if (not shot):
		direction = (player.position - position)
		
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D):
	pass


func _on_timer_timeout() -> void:
	shot = true


func _on_timer_2_timeout() -> void:
	queue_free()
