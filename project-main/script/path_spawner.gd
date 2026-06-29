extends Path2D
var wave_number:int = 0
var enemy_quantity: int = 0
var max_enemy_value: int = 5


@export var timer: Timer
@export var enemy: PackedScene
@export var tower_zone: Area2D
@export var wave_timer: Timer
@export var wave_ui: Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_ui.text = "Wave:" + str(wave_number)
	
func _on_spawner_timeout() -> void:
	if enemy_quantity < max_enemy_value:
		var enemy_scene = enemy.instantiate()
		add_child(enemy_scene)
		enemy_quantity += 1
	else:
		new_wave()
	
func new_wave() -> void:
	wave_number += 1
	await wave_timer.timeout
	max_enemy_value *= 2
	_on_spawner_timeout()
	
	

	
	
