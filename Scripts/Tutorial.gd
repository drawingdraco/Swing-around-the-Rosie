extends Node
var homprojectsc = preload("res://Scenes/HomingSeed.tscn")
@onready var main = get_node("/root/Tutorial/Player")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "Player":
		var homprojectile = homprojectsc.instantiate()
		homprojectile.position = Vector2(1000,0)
		main.add_sibling(homprojectile)
		$Area2D2.monitoring = true


func _on_area_2d_2_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
