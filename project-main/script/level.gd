extends Node2D
@export var unit_scene: PackedScene
@export var money_label: Label
@export var notification: Label
@export var base: Area2D
@export var base_health_ui: ProgressBar


var placing = false
var money:int = 20
var placing_amount:int = 0
var base_health:int = 4
var wave: int = 0
var unit: CharacterBody2D
var boss_damage: int = 2 
var enemy_damage: int = 1
var init_price: int = 2
var init_p_amount: int = 1
var init_b_health: int = 0
var scale_value: float = 1.5


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#updating the base health bar:
	base_health_ui.max_value = base_health
	base_health_ui.value = base_health
	#--------------------------------
	for i in get_tree().get_nodes_in_group("unit"):
		unit = i

#the game will decrease the income if player place the unit down
func _pay_and_build() -> void:
	placing = false
	money -= init_price
	placing_amount += init_p_amount



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
	if base_health == init_b_health:
		get_tree().call_deferred("reload_current_scene")
		
func scale(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.scale_enemy(scale_value)
	elif body.is_in_group("boss"):
		body.scale_boss(scale_value)
		

func _pause() -> void:
	get_tree().paused = true
	$pause_menu/Control.visible = true

func _play() -> void:
	get_tree().paused = false
	$pause_menu/Control.visible = false


func _main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/ui_start.tscn")
