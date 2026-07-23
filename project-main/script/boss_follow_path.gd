extends PathFollow2D
var Speed = 300.0 

func _process(delta: float) -> void:
	set_progress(get_progress() + Speed * delta)
	
	if progress_ratio >= 0.99:
		queue_free()
