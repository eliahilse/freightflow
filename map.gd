extends TileMap

var ground_layer: int = 0
var port_layer: int = 1
var selector_layer: int = 2
var source_id: int = 0
var terrain: int = 0
var atlas_coords: Vector2i = Vector2i(-1,0):
	set(new_coords):
		atlas_coords = new_coords
		
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
		
@onready var port_scene = preload("res://port.tscn")
var ports = {}

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
	var tile : Vector2 = local_to_map(global_mouse_position)
	set_cell(ground_layer, tile, source_id, atlas_coords)
	set_cells_terrain_connect(ground_layer, [tile], 0, terrain)	
	menu_open = false
	
func _on_port_selected(global_mouse_position: Vector2) -> void:
	var tile: Vector2 = local_to_map(global_mouse_position)
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
	var port_number = ports.size()
	ports[port_number] = port
	add_child(port)
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
		
	
