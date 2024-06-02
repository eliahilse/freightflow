extends Node2D


# Referenz zum CanvasLayer
@onready var tile_map = $TileMap
@onready var canvas_layer = $UI
@onready var _1 = $"UI/Control/HBoxContainer/1"
@onready var _2 = $"UI/Control/HBoxContainer/2"
@onready var _3 = $"UI/Control/HBoxContainer/3"
@onready var _4 = $"UI/Control/HBoxContainer/4"

var global_mouse_position:Vector2 = Vector2.ZERO

func _ready():
	# Verbinde das `pressed`-Signal mit der `_on_Button_pressed`-Methode
	_1.connect("pressed", Callable(self, "_on_Button_1_pressed"))
	_2.connect("pressed", Callable(self, "_on_Button_2_pressed"))
	_3.connect("pressed", Callable(self, "_on_Button_3_pressed"))
	_4.connect("pressed", Callable(self, "_on_Button_4_pressed"))

func _input(event):
	# Überprüfe, ob der Event ein Mausklick ist
	if event is InputEventMouseButton and event.pressed:
		
		if (!canvas_layer.visible):
			# Setze die Position des CanvasLayers
			canvas_layer.offset = Vector2(event.global_position.x - 84, event.global_position.y - 56)
			canvas_layer.visible = true
			global_mouse_position = event.global_position
			tile_map.menu_open = true
			return
		
		
		
		
func _process_tile_change():
	canvas_layer.visible = false
	tile_map._on_tile_selected(global_mouse_position)
	
func _process_port_placement():
	canvas_layer.visible = false
	tile_map._on_port_selected(global_mouse_position)
		
func _on_Button_1_pressed():
	tile_map.atlas_coords = Vector2i(3,2)
	_process_tile_change()
	
func _on_Button_2_pressed():
	tile_map.atlas_coords = Vector2i(0,10)
	_process_port_placement()
	
func _on_Button_3_pressed():
	tile_map.atlas_coords = Vector2i(2,0)
	_process_tile_change()

func _on_Button_4_pressed():
	tile_map.atlas_coords = Vector2i(4,0)
	_process_tile_change()
	

