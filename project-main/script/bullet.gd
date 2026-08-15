extends Area2D
var speed: float = 1200.0
var unit: CharacterBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_x(speed * delta)


func _damage(body: Node2D) -> void:
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		body.take_damage(unit.stats["damage"])
		queue_free()
