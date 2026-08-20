extends Path2D
var wave_number:int = 0
var enemy_quantity: int = 0
var max_enemy_value: int = 2
var boss_spawned: bool = false
var boss_count:int = 0

@export var timer: Timer
@export var enemy: PackedScene
@export var tower_zone: Area2D
@export var wave_ui: Label
@export var boss_scene: PackedScene


func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	new_wave()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_ui.text = "Wave:" + str(wave_number)
		
	
func _on_spawner_timeout() -> void:
	if wave_number % 10 != 0:
		if enemy_quantity < max_enemy_value:
			var enemy_scene = enemy.instantiate()
			add_child(enemy_scene)
			enemy_quantity += 1
		else:
			new_wave()
			enemy_quantity = 0
	else:
		boss_spawned = true
		_boss_spawn()

func _boss_spawn() -> void:
	if boss_spawned:
		var boss = boss_scene.instantiate()
		add_child(boss)
		boss_count += 1
		if boss_count <= 1:
			boss_spawned = false
			boss_count -= 1
			new_wave()

		
func new_wave() -> void:
	wave_number += 1
	await get_tree().create_timer(20.0).timeout
	max_enemy_value *= 1.5



	
	

	
	
