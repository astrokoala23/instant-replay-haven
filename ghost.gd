class_name GhostReplayer2D
extends CharacterBody2D

var frames_to_play: Array[Transform2D] = []
var current_frame_index: int = 0

func initialize(frames: Array[Transform2D]) -> void:
	frames_to_play = frames
	current_frame_index = 0

func _physics_process(_delta: float) -> void:
	if frames_to_play.is_empty():
		return

	if current_frame_index < frames_to_play.size():
		global_transform = frames_to_play[current_frame_index]
		current_frame_index += 1
	else:
		set_physics_process(false)
