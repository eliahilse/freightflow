extends Panel

signal operation_entered(operation: int, value: int)
signal delete_fork(operation: int, value: int)

enum Condition {
	GLEICH,
	UNGLEICH,
	GRÖSSER,
	GRÖSSER_GLEICH,
	KLEINER,
	KLEINER_GLEICH,
}

@onready var operand = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Operand
@onready var deleteButton = $HBoxContainer/VBoxContainer/HBoxContainer2/Delete
@onready var slotSelect = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/Slot
@onready var number = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Number
@onready var apply_button = $HBoxContainer/VBoxContainer/MarginContainer/ApplyButton

func _ready():
	apply_button.connect("pressed", Callable(self, "_on_apply_button_pressed"))
	deleteButton.connect("pressed", Callable(self, "_on_delete_button_pressed"))
	
	for condition in Condition.keys():
		operand.add_item(condition)
		
	for i in range(4):
		slotSelect.add_item(str(i+1))
	
	number.text_changed.connect(_on_number_text_changed)

func _on_number_text_changed():
	var current_text = number.text
	var new_text = ""
	var regex = RegEx.new()
	regex.compile("^-?\\d*$")
	
	for i in range(current_text.length()):
		if regex.search(current_text.substr(0, i + 1)):
			new_text = current_text.substr(0, i + 1)
	

	
	if new_text != current_text:
		number.text = new_text
		number.set_caret_column(new_text.length())

func _on_apply_button_pressed():
	var selected_operation = operand.selected
	var selected_slot = slotSelect.selected
	var input_value = int(number.text) if number.text.is_valid_int() else 0
	emit_signal("operation_entered", selected_operation, input_value, selected_slot)
	queue_free()

func _on_delete_button_pressed():
	emit_signal("delete_fork")
	queue_free()


func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		queue_free()
