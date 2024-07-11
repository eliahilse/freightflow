extends CanvasLayer

# Liste von Seiten, die angezeigt werden sollen
var pages = []
# Aktuelle Seite, die angezeigt wird
var current_page = 0
# Aktuelle Position des angezeigten Textes
var current_char = 0
# Timer Referenz
@onready var timer = $Control/Timer
# Label Referenz
@onready var dialog = $Control/Dialog
# AudioPLayer Referenz
@onready var audio = $Control/AudioStreamPlayer2D

signal show_small_captain

# Platzhalter Funtion
func _ready():
	visible = false


'''
Um Text hinzuzufügen diese Funkltion aufrufen
Wenn eine Erklärung über mehere Seiten gehen soll ein mit ';' trennen
'''
func animate_text(new_text):
	# Teile den String in Seiten auf
	pages = new_text.split(";")
	current_page = 0
	current_char = 0
	dialog.text = ""
	visible = true
	
	# Audio
	#audio.stream = load("res://assets/AI_Voiceover.mp3")
	#audio.play()
	
	# Überprüfe, ob der Timer existiert und setze die Wartezeit
	if timer:
		timer.start()
	else:
		print("Timer Node nicht gefunden")

func _on_Timer_timeout():
	if current_page < pages.size():
		# Füge das nächste Zeichen der aktuellen Seite hinzu
		if current_char < pages[current_page].length():
			dialog.text += pages[current_page][current_char]
			current_char += 1
			timer.start() # Timer erneut starten für das nächste Zeichen
		else:
			# Stoppe den Timer, wenn die aktuelle Seite komplett angezeigt wurde
			timer.stop()
	else:
		dialog.text = ""
		timer.stop()

# Funktion zum Wechseln der Seiten
func next_page():
	if current_page < pages.size() and current_char >= pages[current_page].length():
		# Gehe zur nächsten Seite über, wenn die aktuelle Seite komplett angezeigt wurde
		current_page += 1
		current_char = 0
		dialog.text = ""
		if current_page < pages.size():
			# Setze den Timer zurück, um die nächste Seite anzuzeigen
			timer.start()
		else:
			print("Gesamter Text angezeigt: ", dialog.text)  # Debugging-Ausgabe
	if current_page == pages.size():
		visible = false
		emit_signal("show_small_captain")
