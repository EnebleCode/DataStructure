extends Area2D

@export var Next_scene : String

func _on_body_entered(_body: Node2D) -> void:
	GLOBAL._change_scene(Next_scene)
