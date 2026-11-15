class_name PlayerController2D
extends CharacterBody2D

const MAX_SPEED: int = 300
const ACCEL: int = 10
const FRICTION: int = 8

@export_group("Directional Sprites")
@export var texture_down: Texture2D
@export var texture_up: Texture2D
@export var texture_left: Texture2D
@export var texture_right: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var recorded_frames: Array[Transform2D] = []

func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	if input != Vector2.ZERO:
		update_facing_direction(input)
	
	var lerp_weight = delta * (ACCEL if input else FRICTION)
	velocity = lerp(velocity, input * MAX_SPEED, lerp_weight)
	
	move_and_slide()
	
	recorded_frames.append(global_transform)

func update_facing_direction(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		sprite.texture = texture_right if dir.x > 0 else texture_left
	else:
		sprite.texture = texture_down if dir.y > 0 else texture_up

func reset_recording() -> void:
	recorded_frames.clear()
