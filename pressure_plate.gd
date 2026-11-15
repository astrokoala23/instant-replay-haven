extends Area2D
@onready var sprite: Sprite2D = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.modulate = Color.WHITE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	$Sprite2D.modulate = Color.RED


func _on_body_exited(body: Node2D) -> void:
	$Sprite2D.modulate = Color.WHITE
