extends Camera2D
@export var target: Node2D = null

@export var speed: float = 5.0

@export var lock_x: bool = false

@export var lock_y: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if target == null:
		return
	var new_position: Vector2 = target.global_position
	if lock_x:
		new_position.x = global_position.x
	if lock_y:
		new_position.y = global_position.y
	
	global_position = lerp(global_position, new_position, speed*delta)
