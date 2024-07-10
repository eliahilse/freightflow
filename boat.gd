extends CharacterBody2D

class_name Boat

var movement_speed = 100.0
var final_target:Vector2
var waiting = false
var game_started = false
@export var containers: Array[int] = [0, 0, 0, 0]

@onready var navigation_agent = $NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D

signal target_reached

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	
	#set_movement_target(final_target)
	
func set_movement_target(movement_target):
	#print(movement_target)
	#print(global_position)
	navigation_agent.target_position = movement_target
	
func get_containers():
	return containers
	

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		if navigation_agent.target_position == final_target and game_started:
			#game_started = false
			emit_signal("target_reached")
		return
	if waiting or not game_started:
		navigation_agent.set_velocity_forced(Vector2.ZERO)
		return
		
	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	var movement_direction: Vector2 = current_agent_position.direction_to(next_path_position)
	_change_animation(movement_direction)
	
	velocity = movement_direction * movement_speed

	move_and_slide()
	
func _change_animation(direction: Vector2) -> void:
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("right")
		else:
			animated_sprite.play("left")
	else:
		if direction.y > 0:
			animated_sprite.play("down")
		else:
			animated_sprite.play("up")
		
	


func _on_port_reached(container_position, operation, operation_value):
	waiting = true
	
	match operation:
		0:	#Addition
			containers[container_position] += operation_value
		1:	#Subtraktion
			containers[container_position] -= operation_value
		2:	#Multiplikation
			containers[container_position] *= operation_value
		3:	#Division
			containers[container_position] /= operation_value
		4:	#Modulo
			containers[container_position] %= operation_value
	
	await get_tree().create_timer(2.0).timeout
	#set_movement_target(target_array.pop_front())
	waiting = false


func _on_fork_reached():
	#target_array.push_back(next_position)
	#set_movement_target(target_array.pop_front())
	pass
