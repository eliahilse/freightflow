extends CanvasLayer

@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_completed():
	label.visible = true
	if Input.is_action_just_pressed("left_click"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
