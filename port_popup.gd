extends Panel

signal text_entered(text)

@onready var operand = $HBoxContainer/VBoxContainer/HBoxContainer/Operand
@onready var number = $HBoxContainer/VBoxContainer/HBoxContainer/Number
@onready var apply_button = $HBoxContainer/VBoxContainer/MarginContainer/ApplyButton

func _ready():
	apply_button.connect("pressed", Callable(self, "_on_apply_button_pressed"))
	
func _on_apply_button_pressed():
	emit_signal("data entered", number.text)
	queue_free()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		queue_free()
