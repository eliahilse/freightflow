extends CanvasLayer

@onready var small_captain_button = find_child("Captain", true, true)
@onready var instruction_background = find_child("InstructionBackground", true, true)
@onready var dialog = get_parent().find_child("Dialog", true, false)


# Called when the node enters the scene tree for the first time.
func _ready():
	dialog.connect("show_small_captain", Callable(self, "_on_show_small_captain"))
	small_captain_button.connect("pressed", Callable(self, "_on_small_captain_pressed"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_show_small_captain():
	small_captain_button.visible = true
	
func _on_small_captain_pressed():
	instruction_background.visible = true
