extends Node

signal wave_finished

@export var waves: Array[Wave]
@export var time_between_waves: float = 5.0 # in seconds

var current_wave_index = -1
var enemies_spawned_in_wave = 0
var is_spawning = false

@onready var spawn_timer = Timer.new()
@onready var between_wave_timer = Timer.new()

func _ready():
	print("WaveManager ready.")
	add_child(spawn_timer)
	add_child(between_wave_timer)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	between_wave_timer.timeout.connect(start_next_wave)
	start_next_wave()

func start_next_wave():
	# --- FIX ---
	# Check if the NEXT wave index is valid before incrementing the counter.
	if current_wave_index + 1 >= waves.size():
		print("All waves finished!")
		is_spawning = false # Ensure no more spawning can occur
		return

	current_wave_index += 1
	print("Starting wave ", current_wave_index)
	enemies_spawned_in_wave = 0
	is_spawning = true
	var current_wave = waves[current_wave_index]
	spawn_timer.wait_time = current_wave.time_between_spawns
	spawn_timer.start()

func _on_spawn_timer_timeout():
	if not is_spawning:
		return

	# This line is now safe, as current_wave_index will not be out of bounds.
	var current_wave = waves[current_wave_index]
	if enemies_spawned_in_wave < current_wave.enemies_in_wave:
		print("Spawning enemy ", enemies_spawned_in_wave + 1, " of ", current_wave.enemies_in_wave, " in wave ", current_wave_index)
		EventBus.request_spawn_enemy.emit(current_wave.enemy_scene)
		enemies_spawned_in_wave += 1
		spawn_timer.start()
	else:
		print("Wave ", current_wave_index, " finished.")
		is_spawning = false
		spawn_timer.stop()
		wave_finished.emit()

		print("Waiting ", time_between_waves, " seconds for the next wave.")
		between_wave_timer.wait_time = time_between_waves
		between_wave_timer.start()
