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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_body_entered(body):
	#if evaluate_condition():
	#	emit_signal("fork_reached", down_target)
	#else: emit_signal("fork_reached", right_target)
	emit_signal("fork_reached", down_target)

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
