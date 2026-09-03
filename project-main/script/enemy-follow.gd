extends PathFollow2D

var Speed = 200.0
var highst_p_ratio: float = 0.99
@export var enemy: CharacterBody2D


func _process(delta: float) -> void:
	set_progress(get_progress() + Speed * delta)
	
	if progress_ratio >= highst_p_ratio:
		queue_free()
	
