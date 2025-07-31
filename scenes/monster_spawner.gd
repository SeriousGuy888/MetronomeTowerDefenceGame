extends Node

@export var enemy_scene: PackedScene
@export var timer: Timer
@export var enemy_container: Node
@export var spawn_radius: float = 1000.0

func _ready():
	# Ensure the timer is assigned before connecting to its signal
	if timer:
		timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	spawn_monster()

func spawn_monster():
	if enemy_scene and enemy_container:
		var new_enemy = enemy_scene.instantiate()

		# Generate a random angle. TAU is a constant for 2 * PI.
		var spawn_angle = randf_range(0, TAU)

		# Calculate a point on a circle around the global origin (0,0).
		# Vector2.from_angle() is a convenient way to create a unit vector from an angle.
		var spawn_position = Vector2.from_angle(spawn_angle) * spawn_radius
		
		# Set the enemy's global position directly to the calculated point.
		new_enemy.global_position = spawn_position
		
		print("New monster spawned at ", new_enemy.global_position)
		enemy_container.add_child(new_enemy)
