class_name GhostReplayer2D
extends CharacterBody2D

const MAX_SPEED: int = 300 # Optional, kept for consistency

@export_group("Directional Sprites")
@export var texture_down: Texture2D
@export var texture_up: Texture2D
@export var texture_left: Texture2D
@export var texture_right: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var frames_to_play: Array[Transform2D] = []
var current_frame_index: int = 0
var previous_position: Vector2 = Vector2.ZERO

func initialize(frames: Array[Transform2D]) -> void:
	frames_to_play = frames
	current_frame_index = 0
	if not frames_to_play.is_empty():
		previous_position = frames_to_play[0].origin
	modulate = Color.RED

func _physics_process(_delta: float) -> void:
	if frames_to_play.is_empty():
		return

	if current_frame_index < frames_to_play.size():
		var next_transform = frames_to_play[current_frame_index]
		var current_pos = next_transform.origin
		
		var movement_dir = current_pos - previous_position
		
		global_transform = next_transform
		
		if movement_dir.length_squared() > 0.0001:
			update_facing_direction(movement_dir.normalized())
			
		previous_position = current_pos
		current_frame_index += 1
	else:
		set_physics_process(false)

func update_facing_direction(dir: Vector2) -> void:
	if abs(dir.x) > abs(dir.y):
		sprite.texture = texture_right if dir.x > 0 else texture_left
	else:
		sprite.texture = texture_down if dir.y > 0 else texture_up
