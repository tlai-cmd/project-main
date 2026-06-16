extends PathFollow2D

@export var Speed = 20


func _process(delta: float) -> void:
	set_progress(get_progress() + Speed * delta)
