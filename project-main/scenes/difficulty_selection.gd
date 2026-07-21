extends Control
var button_type = null
@export var transition: ColorRect
@export var timer_transition: Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")
	$fade_transition.hide()
	


func _select_map_1() -> void:
	button_type = "map_1"
	transition.show()
	timer_transition.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	

func _end_transition() -> void:
	if button_type == "map_1":
		get_tree().change_scene_to_file("res://scenes/level.tscn")
