extends Node


@export var enemy_container: Node
@export var spawn_radius: float = 500.0

func _ready():
	EventBus.request_spawn_enemy_type.connect(_on_request_spawn_enemy_type)

func _on_request_spawn_enemy_type(enemy_type: Enums.EnemyType, wave_index: int = -1):
	# New spawning method using enemy types
	var enemy_instance = EnemyFactory.create_enemy(enemy_type)
	_spawn_enemy_instance(enemy_instance, wave_index)

func _spawn_enemy_instance(enemy_instance: Enemy, wave_index: int):
	# 1. Pick a random angle from your list of defined lanes.
	var chosen_lane_key = Enums.Lane.keys().pick_random()
	var chosen_angle_deg = Enums.Lane.get(chosen_lane_key)
	# 2. Convert the chosen angle from degrees to radians for calculations.
	var chosen_angle_rad = deg_to_rad(chosen_angle_deg)
	# 3. Calculate the spawn position using the angle and radius.
	var spawn_position = Vector2.from_angle(chosen_angle_rad) * spawn_radius
	# 4. Set the enemy's global position to the calculated spawn point.
	enemy_instance.global_position = spawn_position
	# mark the enemy's wave and lane membership
	enemy_instance.member_of_wave = wave_index
	enemy_instance.lane = chosen_angle_deg
	# 5. Add the new enemy to the designated container node.
	enemy_container.add_child(enemy_instance)
