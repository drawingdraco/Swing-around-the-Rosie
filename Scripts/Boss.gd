extends Area2D
var projectsc = preload("res://Scenes/seed.tscn")
var homprojectsc = preload("res://Scenes/HomingSeed.tscn")
var vinewave = preload("res://Scenes/Vinewabe.tscn")
var rootssc = preload("res://Scenes/roots.tscn")
var puffsc = preload("res://Scenes/Pollen puff.tscn")
@onready var main = get_node("/root/Garden/Sprite2D2")
@onready var Warning = get_node("/root/Garden/Boss/Path2D/PathFollow2D/Warning")
# Called when the node enters the scene tree for the first time.
@export var progress: float = 0.0
func _ready() -> void:
	get_parent().animation = "default"
	Warning.visible = false
	Global.health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += .01
	$"/root/Garden/Boss/Path2D/PathFollow2D".progress_ratio = progress
	Warning.position = ($"/root/Garden/Boss/Path2D/PathFollow2D".position)/4
	Warning.rotation = 0
	if Input.is_action_just_pressed('debug_1'):
		Warning.visible = true
		$"Warning timer".start()
	elif Input.is_action_just_pressed('debug_2'):
		$Timer2.start()
	elif Input.is_action_just_pressed('debug_3'):
		$Timer3.start()
	elif Input.is_action_just_pressed('debug_4'):
		$Timer4.start()
	elif Input.is_action_just_pressed('debug_5'):
		get_parent().animation = "puffing"
		$Timer5.start()


func _on_area_entered(area: Area2D) -> void:
	Global.health -= 2
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	
func _on_attack_timeout() -> void:
	var rand = randi_range(1,5)
	print(rand)
	if rand == 1:
		Warning.visible = true
		$"Warning timer".start()
	elif rand == 2:
		$Timer2.start()
	elif rand == 3:
		$Timer3.start()
	elif rand == 4:
		$Timer4.start()
	elif rand == 5:
		get_parent().animation = "puffing"
		$Timer5.start()
func _on_timer_timeout() -> void:
	var projectile = projectsc.instantiate()
	projectile.position = global_position
	main.add_sibling(projectile)
	


func _on_timer_2_timeout() -> void:
	var homprojectile = homprojectsc.instantiate()
	homprojectile.position = global_position
	main.add_sibling(homprojectile)


func _on_timer_3_timeout() -> void:
	var wave = vinewave.instantiate()
	var rand = randi_range(1,4)
	wave.position = global_position
	if rand == 1:
		wave.position.y -= 420
	elif rand == 2:
		wave.position.y += 420
	elif rand == 3:
		wave.position.x -= 870
	elif rand == 4:
		wave.position.x += 870
	main.add_sibling(wave)


func _on_timer_4_timeout() -> void:
	var roots = rootssc.instantiate()
	var rand = randi_range(1,4)
	if rand == 1:
		roots.position = global_position
	elif rand == 2:
		roots.position = global_position
		roots.position.y += 430
	elif rand == 3:
		roots.position = global_position
		roots.position.x += 860
	elif rand == 4:
		roots.position = global_position
		roots.position.y += 430
		roots.position.x += 860
	main.add_sibling(roots)


func _on_timer_5_timeout() -> void:
	var puff = puffsc.instantiate()
	puff.position = global_position
	main.add_sibling(puff)
	get_parent().animation = "default"


func _on_length_timeout() -> void:
	$Timer.stop()


func _on_warning_timer_timeout() -> void:
	$Timer.start()
	$Timer/Length.start()
	Warning.visible = false
