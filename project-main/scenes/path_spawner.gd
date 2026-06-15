extends Path2D

@export var timer: Timer
@export var enemy: PackedScene
@export var tower_zone: Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_spawner_timeout() -> void:
	var enemy_scene = enemy.instantiate()
	add_child(enemy_scene)

	
	
