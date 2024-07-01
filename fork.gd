extends Area2D

signal fork_reached

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	emit_signal("fork_reached")

func _set_position(fork_position: Vector2):
	position = fork_position
	
func _get_position() -> Vector2:
	return position
