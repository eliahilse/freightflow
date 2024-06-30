extends Label

# Vollständiger Text, der angezeigt werden soll
var full_text = "Hier wird der Text wie bei einer Schreibmaschine angezeigt."
# Aktuelle Position des angezeigten Textes
var current_char = 0
# Timer Referenz
@onready var timer = $Timer

func _ready():
	# Setze den initialen Text auf leer
	text = ""
	# Überprüfe, ob der Timer existiert und setze die Wartezeit
	if timer:
		timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
		timer.wait_time = 0.1
		timer.start()
	else:
		print("Timer Node nicht gefunden")

func _on_Timer_timeout():
	# Füge das nächste Zeichen hinzu, wenn noch nicht das Ende des Textes erreicht ist
	if current_char < full_text.length():
		text += full_text[current_char]
		current_char += 1
	else:
		# Stoppe den Timer, wenn der gesamte Text angezeigt wurde
		timer.stop()
