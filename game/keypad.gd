extends Control

@onready var _1 = $"GridContainer/Button1"
@onready var _2 = $"GridContainer/Button2"
@onready var _3 = $"GridContainer/Button3"
@onready var _4 = $"GridContainer/Button4"
@onready var _5 = $"GridContainer/Button5"
@onready var _6 = $"GridContainer/Button6"
@onready var _7 = $"GridContainer/Button7"
@onready var _8 = $"GridContainer/Button8"
@onready var _9 = $"GridContainer/Button9"
@onready var _0 = $"GridContainer/Button0"
@onready var back = $"GridContainer/ButtonBack"
var number_button_array = []

@onready var input = get_parent()

func _ready():
	number_button_array.append(_0)
	number_button_array.append(_1)
	number_button_array.append(_2)
	number_button_array.append(_3)
	number_button_array.append(_4)
	number_button_array.append(_5)
	number_button_array.append(_6)
	number_button_array.append(_7)
	number_button_array.append(_8)
	number_button_array.append(_9)
	
	for i in range(number_button_array.size()):
		number_button_array[i].connect("pressed", Callable(self, "_on_number_pressed").bind(i))
		
	back.connect("pressed", Callable(self, "_on_back_pressed"))
	
	position = Vector2(700, 800)

func _on_number_pressed(number):
	input.text += str(number)
	
func _on_back_pressed():
	input.text = input.text.substr(0, input.text.length() - 1)
	
