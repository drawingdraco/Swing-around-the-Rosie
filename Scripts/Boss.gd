extends Area2D
var projectsc = preload("res://Scenes/seed.tscn")
var homprojectsc = preload("res://Scenes/HomingSeed.tscn")
var vinewave = preload("res://Scenes/Vinewabe.tscn")
var rootssc = preload("res://Scenes/roots.tscn")
var puffsc = preload("res://Scenes/Pollen puff.tscn")
@onready var main = get_node("/root/Garden/Sprite2D2")
@onready var seed = get_node("/root/Garden/Boss/Path2D/PathFollow2D/Seed")
# Called when the node enters the scene tree for the first time.
@export var progress: float = 0.0
func _ready() -> void:
	get_parent().animation = "default"
	seed.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	Global.health -= 2
	if Global.health <= 0:
		get_tree().change_scene_to_file("res://Scenes/Win.tscn")
	
func _on_attack_timeout() -> void:
	var rand = randi_range(1,5)
	print(rand)
	if rand == 1:
		seed.visible = true
		$Timer.start()
		$Timer/Length.start()
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
	progress += .01
	$"/root/Garden/Boss/Path2D/PathFollow2D".progress_ratio = progress
	main.add_sibling(projectile)
	seed.visible = false


func _on_timer_2_timeout() -> void:
	var homprojectile = homprojectsc.instantiate()
	homprojectile.position = global_position
	main.add_sibling(homprojectile)


func _on_timer_3_timeout() -> void:
	var wave = vinewave.instantiate()
	wave.position = global_position
	wave.position.y -= 620
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
