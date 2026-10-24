extends Area2D
var projectsc = preload("res://Scenes/seed.tscn")
var homprojectsc = preload("res://Scenes/HomingSeed.tscn")
var vinewave = preload("res://Scenes/Vinewabe.tscn")
@onready var main = get_node("/root/Garden")
# Called when the node enters the scene tree for the first time.
@export var progress: float = 0.0
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	Global.health -= 10


func _on_timer_timeout() -> void:
	var projectile = projectsc.instantiate()
	projectile.position = global_position
	progress += .01
	$"/root/Garden/Boss/Path2D/PathFollow2D".progress_ratio = progress
	main.add_child(projectile)


func _on_timer_2_timeout() -> void:
	var homprojectile = homprojectsc.instantiate()
	homprojectile.position = global_position
	main.add_child(homprojectile)


func _on_timer_3_timeout() -> void:
	var wave = vinewave.instantiate()
	wave.position = global_position
	wave.position.y -= 620
	main.add_child(wave)
