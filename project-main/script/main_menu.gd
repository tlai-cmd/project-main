extends Control

var button_type = null
@export var transition: ColorRect
@export var timer_transition: Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _play() -> void:
	button_type = "start"
	transition.show()
	timer_transition.start()
	$fade_transition/AnimationPlayer.play("fade_in")


func _quit() -> void:
	get_tree().quit()


func _end_transition() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/difficulty_selection.tscn")
