class_name Wave
extends Resource

@export var time_between_spawns: float = 0.5 # in seconds
@export var enemy_types: Array[EnemyWaveEntry] = []

# Get total enemies count for the wave
func get_total_enemies() -> int:
	var total = 0
	for entry in enemy_types:
		total += entry.count
	return total

# Get a random enemy scene based on remaining enemies and weights
func get_next_enemy_scene(enemies_spawned_by_type: Dictionary) -> PackedScene:
	# Filter available enemy types that still have enemies to spawn
	var available_types = []
	for entry in enemy_types:
		var spawned_count = enemies_spawned_by_type.get(entry.enemy_scene, 0)
		if spawned_count < entry.count:
			available_types.append(entry)
	
	if available_types.size() == 0:
		return null
	
	# Weighted random selection
	var total_weight = 0.0
	for entry in available_types:
		total_weight += entry.spawn_weight
	
	var random_value = randf() * total_weight
	var current_weight = 0.0
	
	for entry in available_types:
		current_weight += entry.spawn_weight
		if random_value <= current_weight:
			return entry.enemy_scene
	
	# Fallback to first available
	return available_types[0].enemy_scene
