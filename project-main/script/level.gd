extends Node2D
@export var unit_scene: PackedScene
@export var money_label: Label
@export var notification: Label
var placing = false
var money = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _pay_and_build() -> void:
	placing = false
	money -= 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_label.text = "Cash:" + str(money)

func _unit_place_button() -> void:
	if placing == false:
		var unit = unit_scene.instantiate()
		add_child(unit)
