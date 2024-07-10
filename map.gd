extends TileMap

var ground_layer: int = 0
var port_layer: int = 1
var selector_layer: int = 2
var source_id: int = 0
var terrain: int = 0
var changed_cells: Array[Vector2i]
var atlas_coords: Vector2i = Vector2i(-1,0):
	set(new_coords):
		atlas_coords = new_coords
var pattern_index: int
var pattern_mode: bool = false
var last_tile_selected: Vector2i
var menu_open: bool = false:
	set(new_state):
		menu_open = new_state

var port_alternative: int = 0
enum PortOrientation {
	NORTH,
	EAST,
	SOUTH,
	WEST,
	INVALID,
}
		
@onready var boat = get_parent().get_node("boat")
@onready var port_scene = preload("res://port.tscn")
@onready var fork_scene = preload("res://fork.tscn")
var ports = []
var forks = []

func _process(delta):
	if(menu_open): return
	
	# if (last_tile_selected and last_tile_selected != local_to_map(get_global_mouse_position())):
	# 	erase_cell(2, last_tile_selected)
	clear_layer(selector_layer)
		
	var tile = local_to_map(get_global_mouse_position())
	set_cell(selector_layer, tile, 1, Vector2i(0,0), 0)
	last_tile_selected = tile
	
	# Add a tile if the left mouse button is pressed according to its global position


	## Remove a tile if the right mouse button is pressed according to its global position
	#if (Input.is_action_just_pressed("mouse_tile_remove")):
		#var tile : Vector2 = local_to_map(get_global_mouse_position())
		#erase_cell(layer, tile)

func _on_tile_selected(global_mouse_position:Vector2) -> void:
	var tile : Vector2i = Vector2i(local_to_map(global_mouse_position))
	
	if pattern_mode:
		var pattern: TileMapPattern = tile_set.get_pattern(pattern_index)
		set_pattern(ground_layer, tile, pattern)
		changed_cells = pattern.get_used_cells()
		for i in range(changed_cells.size()):
			changed_cells[i] = changed_cells[i] + tile
	else:
		set_cell(ground_layer, tile, source_id, atlas_coords)
		changed_cells = [tile]
		
	if terrain == -1:
		return
	else:
		set_cells_terrain_connect(ground_layer, changed_cells, 0, terrain)
	
func _on_port_selected(global_mouse_position: Vector2) -> void:
	var tile: Vector2i = local_to_map(global_mouse_position)
	var port = port_scene.instantiate()
	var port_position: Vector2i = map_to_local(tile)
	var orientation: PortOrientation = _determine_port_orientation(tile)
	
	match orientation:
		PortOrientation.NORTH:
			atlas_coords = Vector2i(3, 9)
			port_alternative = 0
			port_position.y -= 32
			
		PortOrientation.EAST:
			atlas_coords = Vector2i(3, 8)
			port_alternative = 0
			port_position.x += 32
			
		PortOrientation.SOUTH:
			atlas_coords = Vector2i(4, 9)
			port_alternative = 0
			port_position.y += 32
			
		PortOrientation.WEST:
			atlas_coords = Vector2i(3, 8)
			port_alternative = 1
			port_position.x -= 32
			
		PortOrientation.INVALID:
			return
		
	
	set_cell(port_layer, tile, source_id, atlas_coords, port_alternative)
	port.set_position(port_position)
	ports.append(port)
	add_child(port)
	port.connect("body_entered", Callable(port, "_on_body_entered"))
	port.connect("port_reached", Callable(boat, "_on_port_reached"))
	print("port created")
	
	menu_open = false
	
func _determine_port_orientation(tile: Vector2) -> PortOrientation:
	if get_cell_atlas_coords(ground_layer, tile) == Vector2i(3, 2):
		return PortOrientation.INVALID
		
	#Vector2i(0, 9) or Vector2i(0, 10) or Vector2i(2, 9) or Vector2i(3, 9):
	#if get_cell_atlas_coords(port_layer, tile) == Vector2i(0, 10):
	#	return PortOrientation.INVALID
		
	if get_cell_atlas_coords(port_layer, tile) in [Vector2i(3, 8), Vector2i(3, 9), Vector2i(4, 9)]:
		return PortOrientation.INVALID
	
	if get_cell_atlas_coords(ground_layer, tile + Vector2(0, -1)) == Vector2i(3, 2):
		return PortOrientation.NORTH
		
	if get_cell_atlas_coords(ground_layer, tile + Vector2(0, 1)) == Vector2i(3, 2):
		return PortOrientation.SOUTH
		
	if get_cell_atlas_coords(ground_layer, tile + Vector2(1, 0)) == Vector2i(3, 2):
		return PortOrientation.EAST	
		
	if get_cell_atlas_coords(ground_layer, tile + Vector2(-1, 0)) == Vector2i(3, 2):
		return PortOrientation.WEST
		
	return PortOrientation.INVALID
	
func _on_fork_selected(global_mouse_position: Vector2):
	var tile: Vector2i = local_to_map(global_mouse_position)
	tile += Vector2i(-1, 1)
	if not forks.is_empty():
		for fork in forks:
			if fork._get_position() == map_to_local(tile + Vector2i(1, 0)):
				return
	
	var fork = fork_scene.instantiate()
	var fork_position: Vector2i = map_to_local(tile + Vector2i(1, 0))
	fork.set_position(fork_position)
	
	var pattern: TileMapPattern = tile_set.get_pattern(pattern_index)
	changed_cells = pattern.get_used_cells()
	for i in range(changed_cells.size()):
			changed_cells[i] = changed_cells[i] + tile
			
	set_pattern(ground_layer, tile, pattern)
	
	forks.append(fork)
	add_child(fork)
	fork.connect("body_entered", Callable(fork, "_on_body_entered"))
	fork.connect("fork_reached", Callable(boat, "_on_fork_reached"))
	print("fork created")
		
func is_tile_locked(global_mouse_postion: Vector2) -> bool:
	var tile: Vector2 = local_to_map(global_mouse_postion)
	return get_cell_tile_data(ground_layer, tile).get_custom_data("locked")
	
	
	
