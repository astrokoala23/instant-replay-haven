class_name PlayerController2D
extends CharacterBody2D

const MAX_SPEED: int = 300
const ACCEL: int = 10
const FRICTION: int = 8

var recorded_frames: Array[Transform2D] = []

func _physics_process(delta: float) -> void:
	var input = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	var lerp_weight = delta * (ACCEL if input else FRICTION)
	velocity = lerp(velocity, input * MAX_SPEED, lerp_weight)
	
	move_and_slide()
	
	recorded_frames.append(global_transform)

func reset_recording() -> void:
	recorded_frames.clear()
