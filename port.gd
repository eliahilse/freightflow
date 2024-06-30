extends Area2D

signal port_reached(number: int)

enum PortOperation {
	ADD,
	SUB,
	MUL,
	DIV,
	MOD,
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	emit_signal("port_reached", 0)

func _set_position(port_position: Vector2):
	position = port_position

func _get_position() -> Vector2:
	return position
