extends Area2D

@export var Next_scene : String

func _on_body_entered(_body: Node2D) -> void:
	GLOBAL._is_Interact()
	GLOBAL._set_interactuable(true)
	GLOBAL.isDialog = false
	GLOBAL.next_scene = Next_scene


func _on_body_exited(_body: Node2D) -> void:
	GLOBAL._is_Interact()
	GLOBAL._set_interactuable(false)
	GLOBAL.next_scene = "res://Scenes/Menu.tscn"
