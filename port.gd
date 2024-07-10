extends Area2D

var container_position: int
var operation: PortOperation
var operation_value: int

signal port_reached(container_position: int, operation: PortOperation, value: int)

enum PortOperation {
	ADD,
	SUB,
	MUL,
	DIV,
	MOD,
}
# Called when the node enters the scene tree for the first time.
func _ready():
	container_position = 0
	operation = PortOperation.ADD
	operation_value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _set_container_position(position: int) -> void:
	container_position = position
	
func _set_port_operation() -> void:
	pass
	
func _set_operation_value(value: int) -> void:
	value = operation_value
	
func _on_body_entered(body):
	print("test")
	emit_signal("port_reached", container_position, operation, operation_value)

func _set_position(port_position: Vector2):
	position = port_position

func _get_position() -> Vector2:
	return position
