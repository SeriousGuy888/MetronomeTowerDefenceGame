extends Node

@export var enemy_scene: PackedScene
@export var timer: Timer
@export var enemy_container: Node
@export var spawn_radius: float = 500.0

# Define the 7 lane angles in degrees.
# 0 degrees is to the right. You can customize these angles.
@export var lane_angles_degrees = [0, 45, 90, 135, 180, 225, 270, 315]

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	if enemy_scene and enemy_container:
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
		# 6. Add the new enemy to the designated container node.
		enemy_container.add_child(enemy_instance)
