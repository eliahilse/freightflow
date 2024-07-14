extends Node2D

@export var level1Status: Label
@export var level2Status: Label
@export var loggedInLabel: Label


func _ready():
	
	var levels = [
	["level1", level1Status],
	["level2", level2Status]
	]

	loggedInLabel.text = "Angemeldet als: " + UserDataManager.get_current_user()
	var latestLevel = UserDataManager.get_last_level()
	for level in levels:
		level[1].text = UserDataManager.get_user_level_state_formatted(level[0])
		if level[0] == latestLevel:
			level[1].text += " ++ last opened"
			
func _on_lvl_1_pressed():
	get_tree().change_scene_to_file("res://Level1.tscn")

func _on_lvl_2_pressed():
	get_tree().change_scene_to_file("res://Level2.tscn")

