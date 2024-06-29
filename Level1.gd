extends Node2D


# Referenz zum CanvasLayer
@onready var tile_map = $"MapViewContainer/MapView/TileMap"
@onready var canvas_layer = $UISide
@onready var _1 = $"UISide/Control/VBoxContainer/1"
@onready var _6 = $"UISide/Control/VBoxContainer/6"
@onready var _2 = $"UISide/Control/VBoxContainer/2"
@onready var _3 = $"UISide/Control/VBoxContainer/3"
@onready var _4 = $"UISide/Control/VBoxContainer/4"
@onready var _5 = $"UISide/Control/VBoxContainer/5"
@onready var boat = $"MapViewContainer/MapView/boat"
@onready var map_view = $"MapViewContainer/MapView"

@onready var boat_scene = preload("res://boat.tscn")

var global_mouse_position:Vector2 = Vector2.ZERO
var boat_start_position:Vector2
var target_position:Vector2
var tile_mode:bool = true
var port_mode:bool = false
var is_drawing:bool = false

signal level_completed

func _ready():
	# Verbinde das `pressed`-Signal mit der `_on_Button_pressed`-Methode
	_1.connect("pressed", Callable(self, "_on_Button_1_pressed"))
	_6.connect("pressed", Callable(self, "_on_Button_6_pressed"))
	_2.connect("pressed", Callable(self, "_on_Button_2_pressed"))
	_3.connect("pressed", Callable(self, "_on_Button_3_pressed"))
	_4.connect("pressed", Callable(self, "_on_Button_4_pressed"))
	_5.connect("pressed", Callable(self, "_on_Button_5_pressed"))
	tile_map.atlas_coords = Vector2i(3,2)
	boat_start_position = boat.global_position
	target_position = Vector2(848, 1072)

func _input(event):
	#Wenn ein nicht Mausklick erkannt wird, return
	if event is InputEventKey:
		return
	
	global_mouse_position = event.global_position
	
	if global_mouse_position.x > map_view.size.x:
		return
	
	if event is InputEventMouseButton:
		if port_mode and not tile_mode:
			is_drawing = false
			_process_port_placement()
		if tile_mode and not port_mode:
			_process_tile_change()
			is_drawing = event.pressed
			
	if event is InputEventMouseMotion and is_drawing:
		if tile_mode and not port_mode:
			_process_tile_change()
		
		

func _validate_level_completion():
	emit_signal("level_completed")

func _restart_scene():
	get_tree().reload_current_scene()

func _process_tile_change():
	tile_map._on_tile_selected(global_mouse_position)
	
func _process_port_placement():
	tile_map._on_port_selected(global_mouse_position)
		
func _on_Button_1_pressed():
	tile_map.atlas_coords = Vector2i(3,2)
	tile_map.terrain = 0
	tile_mode = true
	port_mode = false
	
func _on_Button_6_pressed():
	tile_map.atlas_coords = Vector2i(1,4)
	tile_map.terrain = 1
	tile_mode = true
	port_mode = false
	
func _on_Button_2_pressed():
	tile_map.atlas_coords = Vector2i(3,8)
	tile_mode = false
	port_mode = true
	
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


