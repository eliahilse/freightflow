extends TileMap

var layer:int = 0 
var source_id:int = 0
var atlas_coords:Vector2i = Vector2i(-1,0):
	set(new_coords):
		atlas_coords = new_coords
		
var last_tile_selected:Vector2i
var menu_open: bool = false:
	set(new_state):
		menu_open = new_state

func _process(delta):
	if(menu_open): return
	
	if (last_tile_selected and last_tile_selected != local_to_map(get_global_mouse_position())):
		erase_cell(1, last_tile_selected)
		
	var tile = local_to_map(get_global_mouse_position())
	set_cell(1, tile, 1, Vector2i(0,0), 0)
	last_tile_selected = tile
	
	# Add a tile if the left mouse button is pressed according to its global position


	## Remove a tile if the right mouse button is pressed according to its global position
	#if (Input.is_action_just_pressed("mouse_tile_remove")):
		#var tile : Vector2 = local_to_map(get_global_mouse_position())
		#erase_cell(layer, tile)

func _on_tile_selected(global_mouse_position:Vector2) -> void:
	var tile : Vector2 = local_to_map(global_mouse_position)
	set_cell(layer, tile, source_id, atlas_coords)	
	menu_open = false
	
func _on_port_selected(global_mouse_position: Vector2) -> void:
	print("placing port")
	var tile: Vector2 = local_to_map(global_mouse_position)
	set_cell(1, tile, source_id, atlas_coords)
	menu_open = false
	
