extends CharacterBody2D
var enemy: CharacterBody2D
var enemies = [ ]
var closest_enemy: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_tree().get_nodes_in_group("enemy"):
		enemy = i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not closest_enemy == null:
		look_at(closest_enemy.global_position)
	


func _body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		look_at(enemy.global_position)
		closest_enemy = body
		enemies.append(body)
		
		
#for node in enemies:
#if node.get_parent().progress_ratio > closest_enemy.get_parent().progress_ratio:
#closest_enemy == node
		


func _body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemies.erase(body)
		closest_enemy = null
