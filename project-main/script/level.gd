extends Node2D
@export var unit_scene: PackedScene
@export var money_label: Label
@export var notification: Label
@export var base: Area2D
@export var base_health_ui: ProgressBar


var placing = false
var money:int = 3
var placing_amount:int = 0
var base_health:int = 4
var wave: int = 0
var unit: CharacterBody2D
var boss_damage: int = 2 
var enemy_damage: int = 1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_health_ui.max_value = base_health
	base_health_ui.value = base_health
	for i in get_tree().get_nodes_in_group("unit"):
		unit = i

func _pay_and_build() -> void:
	placing = false
	money -= 2
	placing_amount += 1



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_label.text = "Cash:$" + str(money)

func _unit_place_button() -> void:
	if placing == false:
		var unit = unit_scene.instantiate()
		add_child(unit)


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("enemy"):
		base_health -= enemy_damage
		base_health_ui.value = base_health
	if body.is_in_group("boss"):
		base_health -= boss_damage
		base_health_ui.value = base_health
	if base_health == 0:
		get_tree().call_deferred("reload_current_scene")
		

		
