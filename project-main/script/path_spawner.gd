extends Path2D
var wave_number:int = 0
var enemy_quantity: int = 0
var max_enemy_value: int = 2
var boss_spawned: bool = false
var boss_count:int = 0
var max_boss: int = 1
var enemy_scale: int = 1.5
var init_enemy_value: int = 0
var boss: CharacterBody2D
var enemy: CharacterBody2D
var scale_value: float = 10
var wave_changer: bool = false
var body: Node2D

@export var timer: Timer
@export var enemy_value: PackedScene
@export var tower_zone: Area2D
@export var wave_ui: Label
@export var boss_scene: PackedScene


func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	new_wave()
	for b in get_tree().get_nodes_in_group("boss"):
		b = boss
	for e in get_tree().get_nodes_in_group("boss"):
		e = enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	wave_ui.text = "Wave:" + str(wave_number)
		
# (1) spawning enemy function:
func _on_spawner_timeout() -> void:
	if wave_number % 10 != 0:
		wave_changer = true
		if enemy_quantity < max_enemy_value:
			var enemy_scene = enemy_value.instantiate()
			add_child(enemy_scene)
			enemy_quantity += 1
			scale(enemy_scene)
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
			scale(boss)
			new_wave()
#--------------------------------------------------

# (2) proceed a wave after spawning sufficient amount of enemies:		
func new_wave() -> void:
	wave_changer = true
	wave_number += 1
	await get_tree().create_timer(20.0).timeout
	max_enemy_value *= enemy_scale
#------------------------------------------------------

func scale(body: Node2D) -> void:
	if wave_changer == true:
		if body.is_in_group("enemy"):
			body.scale_enemy(scale_value)
		elif body.is_in_group("boss"):
			body.scale_boss(scale_value)
