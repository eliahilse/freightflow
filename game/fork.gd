extends Area2D

signal fork_reached
var right_target = Vector2(0, 0)
var down_target = Vector2(0, 0)

var container_position: int
var condition: Condition
var condition_value: int

@onready var boat = get_parent().get_parent().get_node("boat")

enum Condition {
	EQUAL,
	UNEQUAL,
	GREATER,
	GREATEREQUAL,
	LESS,
	LESSEQUAL,
}

var fork_popup_scene = preload("res://fork_popup.tscn")
var current_popup = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	if evaluate_condition():
		emit_signal("fork_reached", down_target)
	else: emit_signal("fork_reached", right_target)

func _set_position(fork_position: Vector2):
	position = fork_position
	
func _get_position() -> Vector2:
	return position
	
func set_right_target(target: Vector2) -> void:
	right_target = target
	
func get_right_target() -> Vector2:
	return right_target
	
func set_down_target(target: Vector2) -> void:
	down_target = target
	
func get_down_target() -> Vector2:
	return down_target
	
func evaluate_condition() -> bool:
	var result: bool = false
	match condition:
		Condition.EQUAL:
			result = true if boat.containers[container_position] == condition_value else false
		
		Condition.UNEQUAL:
			result = true if boat.containers[container_position] != condition_value else false
			
		Condition.GREATER:
			result = true if boat.containers[container_position] > condition_value else false
			
		Condition.GREATEREQUAL:
			result = true if boat.containers[container_position] >= condition_value else false
			
		Condition.LESS:
			result = true if boat.containers[container_position] < condition_value else false
			
		Condition.LESSEQUAL:
			result = true if boat.containers[container_position] <= condition_value else false
			
	return result
	
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
	
	current_popup = fork_popup_scene.instantiate()
	add_child(current_popup)
	current_popup.connect("operation_entered", Callable(self, "_on_popup_operation_entered"))
	current_popup.connect("delete_fork", Callable(self, "_on_popup_fork_delete"))
	current_popup.connect("tree_exited", Callable(self, "_on_popup_closed"))
	current_popup.show()

func _on_popup_operation_entered(op: int, value: int, slot: int):
	#print("Received operation from popup: ", Condition.keys()[op], " with value: ", value)
	condition = op
	condition_value = value
	container_position = slot
	#print("Updated operation: ", Condition.keys()[condition], ", operation_value: ", condition_value)

func _on_popup_closed():
	#print("Popup closed")
	current_popup = null
	
func _on_popup_fork_delete():
	# todo @ edwin: delete tilemap
	emit_signal("delete_fork_tile", self.position)
	#print("Deleting this fork")
	get_parent().remove_child(self)
	queue_free()
