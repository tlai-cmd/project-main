extends CharacterBody2D
var enemy: CharacterBody2D
var enemies = [ ]
var closest_enemy: CharacterBody2D
var shoot_switch: bool = true
var placing = true
var level: Node2D
var placement_ui:bool = true
var upgrade: bool = true
var cash_placement: int = 2
var max_placement: int = 2
var stats: Dictionary = {
	"damage": 2,
	"cooldown": 1,
	"level": 8
}
var upgrade_cost: Array = [3.0, 5.0, 9.0]
var cost: int = 0
var damage_scale: int = 1.5
var cooldown_scale: float = 0.85

@export var bullet_scene: PackedScene
@export var bullet_spawn: Marker2D
@export var timer: Timer
@export var pivot: Node2D
@export var marker: Marker2D
@export var upgrading_button: Button
@export var upgrading_ui: CanvasLayer
@export var damage_text: Label
@export var cooldown_text: Label


func _ready() -> void:
	for i in get_tree().get_nodes_in_group("enemy"):
		enemy = i
	for node in get_tree().get_nodes_in_group("level"):
		level = node

		
	
func _process(delta: float) -> void:
	#Levels code:
	var current_level = stats["level"]
	# Accessing the array to get the cost of each upgrade
	if current_level - 1 < upgrade_cost.size():
		cost = upgrade_cost[current_level - 1]
	else:
		_max_level()
#-------------------------------
		
	#updating cooldown and damage label + cooldown timer, which link with the current dmg&cd
	timer.wait_time = stats["cooldown"]
	damage_text.text = str(stats["damage"])
	cooldown_text.text = str(stats["cooldown"])
#-------------------------------
	
	#check if the placing is available, which allow the unit to track the player
	if placing == false:
		if not closest_enemy == null:
			marker.look_at(closest_enemy.global_position)
			if shoot_switch == true:
				_shoot()
	else:
		global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("click"):
			#notifications (either valid or not if the unit being placed or not
			if not level.money >= cash_placement:
				placing = true
				get_parent().get_node("notification/Label").text = "Not Enough Money"
				get_parent().get_node("notification/Label").label_settings.font_color = Color(255,0,0,1)
			elif level.money >= cash_placement:
				placing = false
				get_parent().get_node("notification/Label").text = "Place Successfully!"
				get_parent().get_node("notification/Label").label_settings.font_color = Color(0.0, 0.325, 0.0, 1.0)
				if level.placing_amount > max_placement:
					placing = true
					get_parent().get_node("notification/Label").text = "Max Placement!"
					get_parent().get_node("notification/Label").label_settings.font_color = Color(255,0,0,1)
					queue_free()
				else:
					get_parent()._pay_and_build()
				#-----------------------------
				
	#-----------------------------------------------------------
		
					
#adding bullet scene + allow the unit to show it				
func _shoot() -> void:
	var bullet = bullet_scene.instantiate()
	bullet.rotation = bullet_spawn.global_rotation
	bullet.global_position = bullet_spawn.global_position
	bullet.unit = self
	add_sibling(bullet)
	shoot_switch = false
	timer.start()
#--------------------------------

#track the enemies function-------------------------
func _body_entered(body: Node2D) -> void:
	#the code will detect the closest_enemy and add it into the array 
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		closest_enemy = body
		#if the placing_ui detect the users did place a unit -> it will start to follow the unit that move into the area2D
		if placing == false:
			enemies.append(body)
		for node in enemies:
			if node.get_parent().progress_ratio > closest_enemy.get_parent().progress_ratio:
				closest_enemy = node
#---------------------------------------		

#erase/ delete the enemy that left the range
func _body_exited(body: Node2D) -> void:
	if body.is_in_group("enemy") or body.is_in_group("boss"):
		if placing == false:
			enemies.erase(body)
		if body == closest_enemy:
			closest_enemy = null
		print(enemies)
#---------------------------------

#the switch will activate if the cooldown ends
func _bullet_cooldown() -> void:
	shoot_switch = true
#---------------------------------------


#hovering & accessing the upgrading ui	
func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)
	upgrade = true
	
func _not_hover() -> void:
	scale = Vector2(1.0, 1.0)
	upgrade = false

func _click_upg_ui(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click") and upgrade == true:
		upgrading_ui.show()
		
func _max_level() -> void:
	upgrading_button.disabled = true
	upgrading_button.text = "MAX"

func _exit() -> void:
	upgrading_ui.hide()

#------------------------------------------------

#upgrading function and changing units' stats based on each levels
func _upgrade_stats() -> void:
	stats["damage"] = int(stats["damage"] * damage_scale)
	stats["cooldown"] = snappedf(stats["cooldown"] * cooldown_scale, 0.01)
	

	
func _upgrade() -> void:
	if level.money < cost:
		print("unavailable")
	else:
		level.money -= cost
		print(cost)
		stats["level"] += 1
		_upgrade_stats()
		print("upgraded")
#----------------------------------------------------
