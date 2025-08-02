extends Node

@export var waves: Array[Wave]

var is_spawning = false
var enemies_spawned_in_wave = 0
var enemies_remaining = 0
var enemies_spawned_by_type: Dictionary = {}  # Track spawned count per enemy type

@onready var spawn_timer = Timer.new()

func _ready():
	print("WaveManager ready.")
	add_child(spawn_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	EventBus.current_wave_updated.connect(spawn_wave)
	EventBus.enemy_from_wave_died.connect(handle_wave_member_death)

func spawn_wave(current_wave_index: int):
	# --- FIX ---
	# Check if the NEXT wave index is valid before incrementing the counter.
	if current_wave_index >= waves.size():
		print("All waves finished. Cannot spawn wave ", current_wave_index)
		is_spawning = false # Ensure no more spawning can occur
		return

	print("Starting wave ", current_wave_index)
	enemies_spawned_in_wave = 0
	enemies_remaining = 0
	enemies_spawned_by_type.clear()  # Reset enemy type tracking
	is_spawning = true
	var current_wave = waves[current_wave_index]
	spawn_timer.wait_time = current_wave.time_between_spawns
	spawn_timer.start()

func _on_spawn_timer_timeout():
	var current_wave_index = PlaythroughManager.current_wave
	
	if not is_spawning:
		return

	# This line is now safe, as current_wave_index will not be out of bounds.
	var current_wave = waves[current_wave_index]
	var total_enemies = current_wave.get_total_enemies()
	
	if enemies_spawned_in_wave < total_enemies:
		# Get the next enemy to spawn based on the wave configuration
		var enemy_scene = current_wave.get_next_enemy_scene(enemies_spawned_by_type)
		
		if enemy_scene != null:
			print("Spawning enemy ", enemies_spawned_in_wave + 1, " of ", total_enemies, " in wave ", current_wave_index)
			EventBus.request_spawn_enemy.emit(enemy_scene, current_wave_index)
			
			# Update spawn tracking
			enemies_spawned_in_wave += 1
			enemies_remaining += 1
			
			# Track enemy type spawning
			var current_count = enemies_spawned_by_type.get(enemy_scene, 0)
			enemies_spawned_by_type[enemy_scene] = current_count + 1
			
			spawn_timer.start()
		else:
			print("No more enemies to spawn in wave ", current_wave_index)
			is_spawning = false
			spawn_timer.stop()
	else:
		print("Wave ", current_wave_index, " done spawning.")
		is_spawning = false
		spawn_timer.stop()
		

func handle_wave_member_death(wave_index: int):
	var current_wave_index = PlaythroughManager.current_wave
	if wave_index != current_wave_index:
		return
	
	enemies_remaining -= 1
	
	var is_last_wave = current_wave_index >= len(waves)
	if enemies_remaining <= 0 && !is_spawning:
		EventBus.wave_complete.emit(is_last_wave)
