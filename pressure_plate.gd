extends Area2D

signal state_changed(is_entered: bool)

@export var exited_textures: Array[Texture2D] = []  
@export var entered_textures: Array[Texture2D] = [] 

@onready var sprite: Sprite2D = $Sprite2D

var is_entered: bool = false
var current_index: int = 0

func _ready() -> void:
	# Automatically registers every pad so GameManager2D can find them
	add_to_group("pressure_pads")
	
	current_index = randi() % 4
	update_sprite()

func _on_body_entered(body: Node2D) -> void:
	if not is_entered:
		is_entered = true
		update_sprite()
		state_changed.emit(true)

func _on_body_exited(body: Node2D) -> void:
	# Crucial for ghost games: only unpress if NO player or ghost is left on the pad
	if get_overlapping_bodies().is_empty():
		is_entered = false
		update_sprite()
		state_changed.emit(false)

func update_sprite() -> void:
	var active_array = entered_textures if is_entered else exited_textures
	
	if active_array.size() > current_index and active_array[current_index] != null:
		sprite.texture = active_array[current_index]
