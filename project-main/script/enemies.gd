extends CharacterBody2D
var health:int = 2
var level: Node2D
var unit: CharacterBody2D
var money_gained: int = 1

@export var health_ui: ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("level"):
		level = node
	for p in get_tree().get_nodes_in_group("unit"):
		unit = p
		print(unit)
	health_ui.max_value = health
	health_ui.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage(damage: int) -> void:
	if health > 0:
		health -= damage
		health_ui.value = health
	else:
		queue_free()
		level.money += money_gained
		
