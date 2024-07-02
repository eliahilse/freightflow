extends Panel

signal text_entered(text)

@onready var line_edit = $VBoxContainer/LineEdit
@onready var apply_button = $VBoxContainer/ApplyButton

func _ready():
	apply_button.connect("pressed", Callable(self, "_on_apply_button_pressed"))
	
func _on_apply_button_pressed():
	emit_signal("text_entered", line_edit.text)
	queue_free()

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		queue_free()
