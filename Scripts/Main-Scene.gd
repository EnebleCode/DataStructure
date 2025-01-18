extends CanvasLayer

func _ready() -> void:
	GLOBAL.control_instancia.visible = false

func Play() -> void:
	GLOBAL.control_instancia.visible = true
	GLOBAL._change_scene("res://Scenes/level_1.tscn")
	


func Quit() -> void:
	get_tree().quit()
