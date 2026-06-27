extends CharacterBody2D
var health:int = 2
var level: Node2D

@export var health_ui: ProgressBar
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for node in get_tree().get_nodes_in_group("level"):
		level = node
	health_ui.max_value = health
	health_ui.value = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func take_damage() -> void:
	if health > 0:
		health -= 1
		health_ui.value = health
	else:
		queue_free()
		level.money += 1
		
