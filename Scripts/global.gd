extends Node

var interactuable: bool = false #variable para identificar si se esta interactuando.
var isInteractuable:bool = false #variable para saber si el objeto es interactuable.
var info
var isDialog : bool = false
var scene
var next_scene

var control_scene = preload("res://Scenes/Controls.tscn")
var control_instancia = control_scene.instantiate()

var pause_scene = preload("res://Scenes/menu_pausa.tscn")
var pause_instancia = pause_scene.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not get_tree().root.has_node("ControlInstancia"):
		control_instancia.name = "ControlInstancia"
		get_tree().root.add_child.call_deferred(control_instancia)
	
	if not get_tree().root.has_node("PauseInstancia"):
		pause_instancia.name = "PauseInstancia"
		get_tree().root.add_child.call_deferred(pause_instancia)
		
	pause_instancia._set_controles(control_instancia)

func _is_Interact():
	interactuable = not interactuable

func _change_scene(each_scene : String):
	scene = each_scene
	call_deferred("_call_change_scene")

func _call_change_scene():
	
	var new_scene = load(scene).instantiate()
	get_tree().current_scene.queue_free()
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene 
	get_tree().reload_current_scene()
	_controls_reboot()

func _set_interactuable(value : bool):
	isInteractuable = value
	
func start_Dialog():
	isInteractuable = false
	control_instancia.visible = false
	var dialogue_scene = preload("res://Scenes/Prefabs/Dialogos.tscn")
	var dialogue_instance = dialogue_scene.instantiate()
	dialogue_instance.set_dialogues(info)
	get_tree().current_scene.add_child(dialogue_instance)

func show_pause_scene():
	if pause_instancia == null:
		pause_instancia = pause_scene.instantiate()  # Instanciamos la escena si no lo hemos hecho ya
		get_tree().root.add_child(pause_instancia)  # Añadimos la escena al árbol de escenas
		
	pause_instancia._pause()
	
func _controls_reboot():
	pause_instancia._paused_init(false)
