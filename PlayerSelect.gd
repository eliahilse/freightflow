extends Node2D

enum LevelState {
	NEW, 
	ONGOING,
	COMPLETED
}

@export var option_button: OptionButton
@export var text_edit: TextEdit
@export var register_button: Button 

var user_data = {}
var selected_user = ""
var selected_index = 0

func _ready():
	UserDataManager.load_user_data()
	update_user_options()
  

func update_user_options():
	option_button.clear()
	option_button.add_item("Wähle ein Team")
	for user in UserDataManager.user_data:
		option_button.add_item(user)
	option_button.select(0)
	
func _on_login_button_pressed():
	selected_user = option_button.get_item_text(selected_index)
	if selected_user == "Wähle ein Team":
		return
	UserDataManager.set_current_user(selected_user)
	get_tree().change_scene_to_file("res://MainMenu.tscn")

func _on_register_button_pressed():
	var new_user = text_edit.text
	if !new_user or user_data.has(new_user):
		return
	UserDataManager.register_new_user(new_user)
	update_user_options()
	text_edit.clear()

func _on_option_button_item_selected(index):
	selected_user = option_button.get_item_text(index)
	selected_index = index
	if selected_user == "Wähle ein Team":
		selected_user = ""

func get_user_data():
	return user_data.get(selected_user, null)
