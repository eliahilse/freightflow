extends Node

enum LevelState {
	NEW,
	ONGOING,
	COMPLETED
}

var user_data = {}
var selected_user = ""

const USER_DATA_FILE = "res://user_data.json"

func level_state_to_string(level_state):
	if level_state == LevelState.NEW:
		return "Level starten"
	elif level_state == LevelState.ONGOING:
		return "Level fortsetzen"
	else:
		return "Level abgeschlossen"

func _ready():
	load_user_data()
	
func get_user_data():
	return user_data

func load_user_data():
	var file = FileAccess.open(USER_DATA_FILE, FileAccess.READ)
	if file:
		var content = file.get_as_text()
		print(content)
		var my_json = JSON.new()
		var parse_result = my_json.parse(content)
		if parse_result != OK:
			print("Error reading json file: " + parse_result)
			return
		user_data = my_json.get_data()

func save_user_data():
	var file = FileAccess.open(USER_DATA_FILE, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(user_data))
		file.close()

func get_current_user():
	return selected_user

func set_current_user(username: String):
	if user_data.has(username):
		selected_user = username
	else:
		print("User does not exist: ", username)

func edit_user_level(level_name: String, state: LevelState):
	if user_data.has(selected_user) and user_data[selected_user].has(level_name):
		user_data[selected_user][level_name] = state
		save_user_data()
	else:
		print("Invalid user or level name.")

func get_user_level_state(level_name: String):
	if user_data.has(selected_user) and user_data[selected_user].has(level_name):
		return user_data[selected_user][level_name]
	else:
		return LevelState.NEW

func get_user_level_state_formatted(level_name: String):
	if user_data.has(selected_user) and user_data[selected_user].has(level_name):
		return level_state_to_string(
					user_data[selected_user][level_name]
		)
	else:
		return LevelState.NEW

func set_last_level(level_name: String):
	if user_data.has(selected_user):
		user_data[selected_user]["lastLevel"] = level_name
		save_user_data()
	else:
		print("Invalid user")

func get_last_level():
	if user_data.has(selected_user):
		return user_data[selected_user]["lastLevel"]
	else:
		return ""

func register_new_user(new_user: String):
	if not user_data.has(new_user):
		user_data[new_user] = {
			"level1": LevelState.NEW,
			"level2": LevelState.NEW,
			"lastLevel": ""
		}
		save_user_data()
	else:
		print("User already exists: ", new_user)
