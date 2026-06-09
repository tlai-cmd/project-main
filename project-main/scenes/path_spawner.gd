extends Path2D

@export var timer: Timer
@export var enemy: PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var enemy_scene = enemy.instantiate()
	if timer.timeout:
		add_child(enemy_scene)
