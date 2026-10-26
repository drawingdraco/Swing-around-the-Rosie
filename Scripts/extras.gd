extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_check_button_toggled(toggled_on: bool) -> void:
	if Global.beyblade == false:
		Global.beyblade = true
	else:
		Global.beyblade = false


func _on_check_button_2_toggled(toggled_on: bool) -> void:
	if Global.onehit == false:
		Global.onehit = true
	else:
		Global.onehit = false


func _on_check_button_3_toggled(toggled_on: bool) -> void:
	if Global.strongman == false:
		Global.strongman = true
	else:
		Global.strongman = false


func _on_check_button_4_toggled(toggled_on: bool) -> void:
	if Global.anglethreshold == false:
		Global.anglethreshold = true
	else:
		Global.anglethreshold = false

func _on_check_button_5_toggled(toggled_on: bool) -> void:
	if Global.doubleinvincibility == false:
		Global.doubleinvincibility = true
	else:
		Global.doubleinvincibility = false

func _on_check_button_6_toggled(toggled_on: bool) -> void:
	if Global.nocooldown == false:
		Global.nocooldown = true
	else:
		Global.nocooldown = false

func _on_check_button_7_toggled(toggled_on: bool) -> void:
	if Global.invincibledodge == false:
		Global.invincibledodge = true
	else:
		Global.invincibledodge = false


func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
