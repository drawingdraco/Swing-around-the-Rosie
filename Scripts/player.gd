extends CharacterBody2D


const SPEED = 600.0
enum Dir { Right, Left, Down, Up }
var direction = Dir.Down
var screen_size # Size of the game window.
var mousepos = Vector2(0,0)
const DODGE_SPEED: float = 900.0
const DODGE_DURATION: float = 0.3

var dodge_roll_dir: Vector2 = Vector2.ZERO
var dodge_roll_timer: float = 0.0

var can_take_damage: bool = true
var invincible = false

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	if dodge_roll_timer > 0.0:
		_dodge_logic(delta)
	else:
		_movement(delta)
	move_and_slide()
	
func _movement (delta: float) -> void:
	var input_vector = Vector2(
		Input.get_action_strength ("move_right") -Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down")- Input.get_action_strength ("move_up")
	).normalized()

	velocity = lerp(velocity, input_vector * SPEED, 22.0 *delta)
	
	if Input.is_action_just_pressed("dodge"):
		if input_vector != Vector2.ZERO:
			dodge_roll(input_vector)
		elif velocity.length() > 0.1:
			dodge_roll(velocity.normalized())

func dodge_roll(direction: Vector2) -> void:
	dodge_roll_dir = direction
	dodge_roll_timer = DODGE_DURATION
	
func _dodge_logic(delta: float) -> void:
	var elapsed_percent = 1.0 - (dodge_roll_timer / DODGE_DURATION)
	var current_speed = lerp(DODGE_SPEED, DODGE_SPEED*0.5, elapsed_percent)
	
	velocity = dodge_roll_dir * current_speed
	
	dodge_roll_timer -= delta
	
	if dodge_roll_timer <= 0.0:
		dodge_roll_dir = Vector2.ZERO
func _on_rotation_point_my_signal() -> void:
	#moves the player in a dash twoards the node playerpivot
	var pivot_global_position = $"rotation point/playerpivot".global_position
	var direction_to_pivot = (pivot_global_position - global_position).normalized()
	velocity = direction_to_pivot * SPEED
	velocity *= 6
	velocity/=16
	dodge_roll(direction_to_pivot)


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area)
	if !invincible and area.name != "Boss":
		Global.phealth -= 1
		print("health ", Global.phealth)
		invincible = true
		$Hit.start()
		if Global.phealth<=0:
			get_tree().change_scene_to_file("res://Scenes/loose.tscn")


func _on_hit_timeout() -> void:
	invincible = false
