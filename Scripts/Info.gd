@tool
extends Node2D

@export var img_sprite:CompressedTexture2D
@onready var sprite:Sprite2D = $Sprite2D
@export var informacion :Array = []

func _ready() -> void:
	sprite.texture = img_sprite

func _on_area_2d_body_entered(_body: Node2D) -> void:
	GLOBAL._is_Interact()
	print("Quieres informacion")
	GLOBAL._set_interactuable(true)
	GLOBAL.info = informacion
	GLOBAL.isDialog = true


func _on_area_2d_body_exited(_body: Node2D) -> void:
	GLOBAL._is_Interact()
	GLOBAL._set_interactuable(false)
	GLOBAL.info = null
	GLOBAL.isDialog = false
	
