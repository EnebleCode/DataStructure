extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -220.0
var life = 5
var is_front = true
var is_interact:bool = true
@onready var animator = $Sprite2D
var iconInteract = preload("res://Icons/input-prompts/Tiles/tile_0014.png")
var btnInteract = Sprite2D.new()

var pause_scene = preload("res://Scenes/menu_pausa.tscn")
var pause_instancia = pause_scene.instantiate()

@onready var collision_area = $Area2D

#@export var scene : String

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	btnInteract.texture = iconInteract
	btnInteract.position = Vector2(0,-20)
	btnInteract.visible = false
	add_child(btnInteract)

func _physics_process(delta):
	
	btnInteract.visible = GLOBAL.isInteractuable
	
	if Input.is_action_just_pressed("E") and GLOBAL.isInteractuable==true:
		print("estas interactuando")
		if GLOBAL.isDialog == true:
			GLOBAL.start_Dialog()
		else:
			GLOBAL._change_scene(GLOBAL.next_scene)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("Esc"):
		GLOBAL.show_pause_scene()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("A", "D")
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	fliv()
	update_animations()
	move_and_slide()

func fliv():
	if (is_front==true and velocity.x < 0) or (is_front == false and velocity.x>0):
		scale.x *= -1
		is_front=!is_front
		
func update_animations():
	if not is_on_floor():
		if velocity.y < 0:
			animator.play("Jump")
		else:
			animator.play("Fall")
			return
	if velocity.x:
		animator.play("Walk")
	else:
		animator.play("Idle")

func Damage(dam):
	life -= dam
	print("Recibi ",dam," de Daño")
	if life<=0:
		dead()
		

func dead():
	print("me mori")
	
	call_deferred("reload_scene")

func reload_scene():
	var scene = get_tree().current_scene.scene_file_path
	GLOBAL._change_scene(scene)

@warning_ignore("unused_parameter")
func _colision_damage(body: Node2D) -> void:
	print("¡Colisión con un tile en la capa 4!")
	Damage(10)

func interactuar():
	btnInteract = true
