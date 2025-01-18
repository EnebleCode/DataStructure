extends CanvasLayer

var dialogues: Array = []
var current_index: int = 0
var isLast = false

# Referencias a nodos
@onready var dialogue_label = $TextureRect/Label
@onready var next_button = $TextureRect/Button

func set_dialogues(new_dialogues: Array):
	dialogues = new_dialogues
	current_index = 0  # Reinicia el índice
	update_dialogue()
	
func Set_dialogues_Last(new_dialogues: Array):
	dialogues = new_dialogues
	current_index = 0  # Reinicia el índice
	update_dialogue()
	isLast = true

func _ready():
	#dialogues = [
	#	"Hola, ¿cómo estás?",
	#	"Bienvenido al juego.",
	#	"Espero que disfrutes tu experiencia.",
	#	"¡Buena suerte!"
	#	]
	#update_dialogue()
	next_button.connect("pressed", Callable(self, "_on_next_button_pressed"))

func _input(_event):
	if Input.is_action_just_pressed("Esc"):
		queue_free()

func update_dialogue():
	if dialogue_label == null:
		print("Error: dialogue_label es Nil antes de actualizar.")
		return
	if current_index < dialogues.size():
		dialogue_label.text = dialogues[current_index]
	else:
		GLOBAL._set_interactuable(true)
		GLOBAL.control_instancia.visible = true
		queue_free()


func _on_button_pressed() -> void:
	current_index += 1
	update_dialogue()
