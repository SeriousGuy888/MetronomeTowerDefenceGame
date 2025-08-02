extends Node2D

@export var projectile_container: Node
@export var enemy_container: Node

const SHINY_FRISBEE = preload("res://scenes/projectiles/shiny_frisbee.tscn")

func _ready() -> void:
	EventBus.request_add_projectile_to_scene.connect(_on_request_spawn_projectile)
	EventBus.request_spawn_shiny_frisbee_in_lane.connect(_on_request_spawn_shiny_frisbee_in_lane)
	
	EventBus.wave_complete.connect(handle_wave_complete)
	EventBus.request_next_wave.connect(request_next_wave)
	
	PlaythroughManager.start_game()

func handle_wave_complete(is_last_wave: bool):
	if PlaythroughManager.game_state != Enums.GameState.BATTLE:
		# only accept signal if there was actually a wave happening
		# (i.e. don't do anything if the game is already over)
		return
	
	if is_last_wave:
		print("game over - victory")
		return
	
	print("wave ", PlaythroughManager.current_wave, " defeated. moving to build mode...")
	PlaythroughManager.game_state = Enums.GameState.BUILD

func request_next_wave():
	PlaythroughManager.game_state = Enums.GameState.BATTLE
	PlaythroughManager.current_wave += 1


func _on_request_spawn_projectile(
		projectile: Projectile,
		spawn_position: Vector2) -> void:
	projectile.global_position = spawn_position
	projectile_container.add_child(projectile)

func _on_request_spawn_shiny_frisbee_in_lane(lane: Enums.Lane):
	# really specific function because can't find a better way
	# game jam game anyway
	var spawn_position = $metronome.get_turret_slot_global_position(lane)
	if spawn_position:
		var instance = SHINY_FRISBEE.instantiate()
		instance.should_split = false
		instance.lane = lane
		_on_request_spawn_projectile(instance, spawn_position)
