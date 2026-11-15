class_name GameManager2D
extends Node

@export var player: CharacterBody2D
@export var ghost_scene: PackedScene
@export var spawn_point: Node2D # Starting point

@onready var player_recorder: CharacterBody2D = player

var all_ghosts_data: Array[Array] = []
var active_ghosts: Array[Node2D] = []

func _unhandled_input(event: InputEvent) -> void:
	print("Input received: ", event.as_text())
	# Press R
	if event.is_action_pressed("restart"):
		print("Triggered")
		trigger_restart_and_spawn_ghost()

func trigger_restart_and_spawn_ghost() -> void:
	print("--- Restart Triggered ---")
	
	if player_recorder:
		print("Recorded frames count: ", player_recorder.recorded_frames.size())
		
	if player_recorder and not player_recorder.recorded_frames.is_empty():
		var new_run: Array[Transform2D] = []
		new_run.assign(player_recorder.recorded_frames)
		all_ghosts_data.append(new_run)

		for ghost in active_ghosts:
			if is_instance_valid(ghost):
				ghost.queue_free()
		active_ghosts.clear()

		for ghost_data in all_ghosts_data:
			var ghost_instance = ghost_scene.instantiate() as GhostReplayer2D
			get_tree().current_scene.add_child(ghost_instance)
			ghost_instance.global_transform = spawn_point.global_transform
			
			ghost_instance.initialize(ghost_data)
			active_ghosts.append(ghost_instance)
	else:
		print("Condition FAILED! Either player_recorder is null or frames are empty.")

	player.global_transform = spawn_point.global_transform
	player.velocity = Vector2.ZERO
	
	player_recorder.reset_recording()
