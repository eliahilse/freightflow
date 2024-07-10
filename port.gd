extends Area2D

var container_position: int
var operation: PortOperation
var operation_value: int
var next_target: Vector2
signal delete_port_tile(position: Vector2)

signal port_reached(container_position: int, operation: PortOperation, value: int)
var port_popup_scene = preload("res://port_popup.tscn")
var current_popup = null

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
	emit_signal("port_reached", container_position, operation, operation_value, next_target)

func _set_position(port_position: Vector2):
	position = port_position

func _get_position() -> Vector2:
	return position
	
func set_next_target(target: Vector2) -> void:
	next_target = target
	
func get_next_target() -> Vector2:
	return next_target
	
func _input(event):
	if (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT) or \
	   (event is InputEventScreenTouch and event.pressed):
		var click_position = event.position
		if _is_point_inside(click_position):
			open_port_popup()

func _is_point_inside(point: Vector2) -> bool:
	var shape = $CollisionShape2D.shape
	var local_point = to_local(point)
	
	if shape is RectangleShape2D:
		var extents = shape.extents
		var x_left_ext = 32
		var x_right_ext = 32
		var y_top_ext = 32
		var y_bottom_ext = 32
		var x_check = local_point.x > -extents.x - x_left_ext and local_point.x < extents.x + x_right_ext
		var y_check = local_point.y > -extents.y - y_top_ext and local_point.y < extents.y + y_bottom_ext
		return x_check and y_check
	else:
		push_error("Unsupported collision shape")
		return false

func open_port_popup():
	if current_popup != null and is_instance_valid(current_popup):
		return
	
	current_popup = port_popup_scene.instantiate()
	add_child(current_popup)
	current_popup.connect("operation_entered", Callable(self, "_on_popup_operation_entered"))
	current_popup.connect("delete_port", Callable(self, "_on_popup_port_delete"))
	current_popup.connect("tree_exited", Callable(self, "_on_popup_closed"))
	current_popup.show()

func _on_popup_operation_entered(op: int, value: int, slot: int):
	print("Received operation from popup: ", PortOperation.keys()[op], " with value: ", value)
	operation = op
	operation_value = value
	container_position = slot
	print("Updated operation: ", PortOperation.keys()[operation], ", operation_value: ", operation_value)

func _on_popup_closed():
	print("Popup closed")
	current_popup = null
	
func _on_popup_port_delete():
	emit_signal("delete_port_tile", self.position)
	print("Deleting this port")
	get_parent().remove_child(self)
	queue_free()

	
