extends CharacterBody2D
var enemy: CharacterBody2D
var enemies = [ ]
var closest_enemy: CharacterBody2D
var shoot_switch: bool = true

@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
@export var timer: Timer
@export var pivot: Node2D

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("enemy"):
		enemy = i


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not closest_enemy == null:
		pivot.look_at(closest_enemy.global_position)
		if shoot_switch == true:
			_shoot()
	
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = bullet_spawn.global_rotation + deg_to_rad(90)
	bullet.global_position = bullet_spawn.global_position
	add_sibling(bullet)
	shoot_switch = false
	timer.start()
	
func _body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		closest_enemy = body
		enemies.append(body)
		for node in enemies:
			if node.get_parent().progress_ratio > closest_enemy.get_parent().progress_ratio:
				closest_enemy = node
		


func _body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		enemies.erase(body)
		if body == closest_enemy:
			closest_enemy = null
		print(enemies)


func _bullet_cooldown() -> void:
	shoot_switch = true
