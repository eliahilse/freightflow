extends CharacterBody2D

class_name Boat

var movement_speed = 100.0
var fork_position = Vector2(40.0, 310.0)
var port_position = Vector2(500, 500)
var target_array = [port_position, fork_position]
var waiting = false
@export var container = 0

@onready var navigation_agent = $NavigationAgent2D

func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0
	
	call_deferred("actor_setup")
	
func actor_setup():
	await get_tree().physics_frame
	
	set_movement_target(target_array.pop_front())
	
func set_movement_target(movement_target):
	navigation_agent.target_position = movement_target
	
func get_container():
	return container
	

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	if waiting:
		navigation_agent.set_velocity_forced(Vector2.ZERO)
		return
		
	var current_agent_position = global_position
	var next_path_position = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed

	move_and_slide()


func _on_port_reached(port_number):
	var format_string = "Doing something at Port %s"
	var message = format_string % port_number
	print(message)
	container += 1
	waiting = true
	await get_tree().create_timer(2.0).timeout
	set_movement_target(target_array.pop_front())
	waiting = false


func _on_fork_reached(next_position):
	target_array.push_back(next_position)
	set_movement_target(target_array.pop_front())
