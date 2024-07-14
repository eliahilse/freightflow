extends Node2D

@onready var map = get_parent()
@onready var loop_start = $"LoopStart"
@onready var loop_exit = $"LoopExit"

# Called when the node enters the scene tree for the first time.
func _ready():
	loop_start.connect("body_entered", Callable(self, "_on_loop_start_entered"))
	loop_exit.connect("body_entered", Callable(self, "_on_loop_exit_entered"))


func _on_loop_start_entered(body):
	await get_tree().create_timer(0.5).timeout
	map.set_cell(0, map.local_to_map(loop_start.position) + Vector2i(-1, 0), 0, Vector2(3, 2), 1)
	map.set_cell(0, map.local_to_map(loop_exit.position) + Vector2i(1, 0), 0, Vector2(3, 2), 0)
	
func _on_loop_exit_entered(body):
	await get_tree().create_timer(0.5).timeout
	map.set_cell(0, map.local_to_map(loop_start.position) + Vector2i(-1, 0), 0, Vector2(3, 2), 0)
	map.set_cell(0, map.local_to_map(loop_exit.position) + Vector2i(1, 0), 0, Vector2(3, 2), 1)
