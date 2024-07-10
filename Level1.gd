extends Node2D


# Referenz zum CanvasLayer
@onready var tile_map = $"MapViewContainer/MapView/TileMap"
@onready var canvas_layer = $UISide
@onready var _1 = find_child("1", true, false)
@onready var _2 = find_child("2", true, false)
@onready var _3 = find_child("3", true, false)
@onready var _4 = find_child("4", true, false)
@onready var _5 = find_child("5", true, false)
@onready var _6 = find_child("6", true, false)
@onready var _7 = find_child("7", true, false)
@onready var _cursor = find_child("Cursor", true, false)
@onready var boat = $"MapViewContainer/MapView/boat"
@onready var map_view = $"MapViewContainer/MapView"

@onready var boat_scene = preload("res://boat.tscn")

var global_mouse_position:Vector2 = Vector2.ZERO
var boat_start_position:Vector2
var target_position:Vector2
var tile_mode:bool = true
var port_mode:bool = false
var is_drawing:bool = false
var touch_mode: bool = false

enum PlacementMode {
	CURSOR,
	TILE,
	PORT,
	FORK,
	LOOP,
}
var mode: PlacementMode = PlacementMode.TILE

signal level_completed

func _ready():
	# Verbinde das `pressed`-Signal mit der `_on_Button_pressed`-Methode
	_1.connect("pressed", Callable(self, "_on_Button_1_pressed"))
	_6.connect("pressed", Callable(self, "_on_Button_6_pressed"))
	_2.connect("pressed", Callable(self, "_on_Button_2_pressed"))
	_7.connect("pressed", Callable(self, "_on_Button_7_pressed"))
	_3.connect("pressed", Callable(self, "_on_Button_3_pressed"))
	_4.connect("pressed", Callable(self, "_on_Button_4_pressed"))
	_5.connect("pressed", Callable(self, "_on_Button_5_pressed"))
	_cursor.connect("pressed", Callable(self, "_on_cursor_pressed"))
	tile_map.atlas_coords = Vector2i(3,2)
	boat_start_position = boat.global_position
	target_position = Vector2(848, 1072)

func _unhandled_input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		touch_mode = true
	if touch_mode:
		_handle_touch_input(event)
		return

	#Wenn ein nicht Mausklick erkannt wird, return
	if event is InputEventKey:
		return
	
	global_mouse_position = event.global_position
	
	if global_mouse_position.x > map_view.size.x:
		return
		
	if tile_map.is_tile_locked(global_mouse_position):
		is_drawing = false
		return
	
	if event is InputEventMouseButton:
		match mode:
			PlacementMode.TILE:
				_process_tile_change()
				is_drawing = event.pressed
			PlacementMode.PORT:
				is_drawing = false
				_process_port_placement()
			PlacementMode.FORK:
				is_drawing = false
				_process_fork_placement()
			PlacementMode.LOOP:
				pass
			
	if event is InputEventMouseMotion and is_drawing:
		if mode == PlacementMode.TILE:
			_process_tile_change()
		
func _handle_touch_input(event):
	global_mouse_position = event.position
	
	if tile_map.is_tile_locked(global_mouse_position):
		is_drawing = false
		return
	
	if event is InputEventScreenTouch:
		match mode:
			PlacementMode.TILE:
				_process_tile_change()
				is_drawing = event.pressed
			PlacementMode.PORT:
				is_drawing = false
				_process_port_placement()
			PlacementMode.FORK:
				is_drawing = false
				_process_fork_placement()
			PlacementMode.LOOP:
				pass
			
	if event is InputEventScreenDrag and is_drawing:
		if mode == PlacementMode.TILE:
			_process_tile_change()

func _validate_level_completion():
	emit_signal("level_completed")

func _restart_scene():
	get_tree().reload_current_scene()

func _process_tile_change():
	tile_map._on_tile_selected(global_mouse_position)
	
func _process_port_placement():
	tile_map._on_port_selected(global_mouse_position)
	
func _process_fork_placement():
	tile_map._on_fork_selected(global_mouse_position)
		
func _on_Button_1_pressed():
	tile_map.atlas_coords = Vector2i(3,2)
	tile_map.terrain = 0
	mode = PlacementMode.TILE
	tile_map.pattern_mode = false
	
func _on_Button_6_pressed():
	tile_map.atlas_coords = Vector2i(1, 4)
	tile_map.terrain = 1
	mode = PlacementMode.TILE
	tile_map.pattern_mode = false
	
func _on_Button_2_pressed():
	tile_map.atlas_coords = Vector2i(3, 8)
	mode = PlacementMode.PORT
	tile_map.pattern_mode = false
	
func _on_Button_7_pressed():
	tile_map.pattern_index = 0
	tile_map.terrain = -1
	mode = PlacementMode.FORK
	tile_map.pattern_mode = true
	
func _on_Button_3_pressed():
	boat.final_target = target_position
	boat.set_movement_target(target_position)
	boat.game_started = true

func _on_Button_4_pressed():
	boat.game_started = false
	boat.global_position = boat_start_position
	
func _on_Button_5_pressed():
	_restart_scene()
	
	
func _on_boat_target_reached():
	_validate_level_completion()


