extends CharacterBody2D
var enemy: CharacterBody2D
var enemies = [ ]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("enemy"):
		enemy = i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _body_entered(body: Node2D) -> void:
	look_at(enemy.global_position)
	if body == enemy:
		enemies.append(body)


func _body_exited(body: Node2D) -> void:
	if body == enemy:
		enemies.erase(body)
