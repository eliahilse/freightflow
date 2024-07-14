extends CanvasLayer

@onready var completed = $Completed
@onready var failed = $Failed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_completed():
	completed.visible = true
	if Input.is_action_just_pressed("left_click"):
		get_tree().change_scene_to_file("res://MainMenu.tscn")
		
func _on_level_failed(level_number: int):
	failed.visible = true
	if Input.is_action_just_pressed("left_click"):
		if level_number == 1:
			get_tree().change_scene_to_file("res://Level1.tscn")
		elif level_number == 2:
			get_tree().change_scene_to_file("res://Level2.tscn")
	
	
