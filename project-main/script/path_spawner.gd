extends Path2D
var wave_number:int = 0
var enemy_quantity: int = 0
var max_enemy_value: int = 2
var boss_spawned: bool = false
var boss_count:int = 0
var max_boss: int = 1
var enemy_scale: int = 1.5
var init_enemy_value: int = 0

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
		
# (1) spawning enemy function:
func _on_spawner_timeout() -> void:
	if wave_number % 10 != 0:
		if enemy_quantity < max_enemy_value:
			var enemy_scene = enemy.instantiate()
			add_child(enemy_scene)
			enemy_quantity += 1
		else:
			new_wave()
			enemy_quantity = init_enemy_value
	else:
		boss_spawned = true
		_boss_spawn()

func _boss_spawn() -> void:
	if boss_spawned:
		var boss = boss_scene.instantiate()
		add_child(boss)
		boss_count += max_boss
		if boss_count <= max_boss:
			boss_spawned = false
			boss_count -= max_boss
			new_wave()
#--------------------------------------------------

# (2) proceed a wave after spawning sufficient amount of enemies:		
func new_wave() -> void:
	wave_number += 1
	await get_tree().create_timer(20.0).timeout
	max_enemy_value *= enemy_scale
#------------------------------------------------------


	
	

	
	
