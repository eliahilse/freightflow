extends Panel

signal operation_entered(operation: int, value: int)
signal delete_port(operation: int, value: int)

enum PortOperation {
	ADD,
	SUB,
	MUL,
	DIV,
	MOD,
}

@onready var operand = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Operand
@onready var deleteButton = $HBoxContainer/VBoxContainer/HBoxContainer2/Delete
@onready var slotSelect = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/Slot
@onready var slotSelect2 = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer5/Slot
@onready var number = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer3/Number
@onready var targetSelect = $HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer4/Target
@onready var apply_button = $HBoxContainer/VBoxContainer/MarginContainer/ApplyButton

func _ready():
	apply_button.connect("pressed", Callable(self, "_on_apply_button_pressed"))
	deleteButton.connect("pressed", Callable(self, "_on_delete_button_pressed"))
	
	for operation in PortOperation.keys():
		operand.add_item(operation)
		
	slotSelect2.add_item("-")
	for i in range(4):
		slotSelect.add_item(str(i+1))
		slotSelect2.add_item(str(i+1))
		targetSelect.add_item(str(i+1))
	
	DisplayServer.virtual_keyboard_show('')
	
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
	var selected_slot2 = slotSelect2.selected - 1
	var input_value = int(number.text) if number.text.is_valid_int() else 0
	var target_slot = targetSelect.selected
	emit_signal("operation_entered", selected_operation, input_value, selected_slot, selected_slot2, target_slot)
	queue_free()

func _on_delete_button_pressed():
	emit_signal("delete_port")
	queue_free()


func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		queue_free()
