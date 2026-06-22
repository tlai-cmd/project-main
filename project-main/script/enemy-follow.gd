extends PathFollow2D

var Speed = 20
@export var enemy: CharacterBody2D

func _process(delta: float) -> void:
	set_progress(get_progress() + Speed * delta)
	
	if progress_ratio >= 0.99:
		queue_free()
	
