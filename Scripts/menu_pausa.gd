extends CanvasLayer

var Controles:CanvasLayer

func _ready() -> void:
	self.visible = false

func _on_menu_principal_pressed() -> void:
	get_tree().paused = false
	if get_tree().paused == true:
		print("juego pausado")
	GLOBAL._change_scene("res://Scenes/Menu.tscn")

func _pause():
	get_tree().paused = not get_tree().paused
	self.visible = not self.visible
	Controles.visible = not Controles.visible

func _on_quit_pressed() -> void:
	get_tree().quit()

func _set_controles(n :Node):
	Controles = n


func _on_play_pressed() -> void:
	_pause()

func _paused_init(ispause: bool):
	get_tree().paused = ispause
	self.visible = ispause
	Controles.visible = not ispause
