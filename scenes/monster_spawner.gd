extends Node


@export var enemy_container: Node
@export var spawn_radius: float = 500.0
@export var lane_angles_degrees = [0, 45, 90, 135, 180, 225, 270, 315]

func _ready():
	EventBus.request_spawn_enemy.connect(_on_request_spawn_enemy)

func _on_request_spawn_enemy(enemy_scene: PackedScene, wave_index: int = -1):
	# 1. Pick a random angle from your list of defined lanes.
	var chosen_angle_deg = lane_angles_degrees.pick_random()
	# 2. Convert the chosen angle from degrees to radians for calculations.
	var chosen_angle_rad = deg_to_rad(chosen_angle_deg)
	# 3. Calculate the spawn position using the angle and radius.
	var spawn_position = Vector2.from_angle(chosen_angle_rad) * spawn_radius
	# 4. Create an instance of the enemy scene.
	var enemy_instance = enemy_scene.instantiate()
	# 5. Set the enemy's global position to the calculated spawn point.
	enemy_instance.global_position = spawn_position
	# mark the enemy's wave membership
	enemy_instance.member_of_wave = wave_index
	# 6. Add the new enemy to the designated container node.
	enemy_container.add_child(enemy_instance)
