extends Node

@export var waves: Array[Wave]

var is_spawning = false
var enemies_spawned_in_wave = 0
var enemies_remaining = 0

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
	if enemies_spawned_in_wave < current_wave.enemies_in_wave:
		print("Spawning enemy ", enemies_spawned_in_wave + 1, " of ", current_wave.enemies_in_wave, " in wave ", current_wave_index)
		EventBus.request_spawn_enemy.emit(current_wave.enemy_scene, current_wave_index)
		enemies_spawned_in_wave += 1
		enemies_remaining += 1
		spawn_timer.start()
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
