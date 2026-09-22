extends PathFollow2D
var Speed = 100.0
@export var boss_character: CharacterBody2D 

func _process(delta: float) -> void:
	set_progress(get_progress() + Speed * delta)
	
	if progress_ratio >= 0.99:
		queue_free()
