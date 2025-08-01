extends Node2D

@export var projectile_container: Node
@export var enemy_container: Node

func _ready() -> void:
	EventBus.request_spawn_projectile.connect(_on_request_spawn_projectile)
		
	EventBus.wave_complete.connect(handle_wave_complete)
	EventBus.request_next_wave.connect(request_next_wave)
	
	PlaythroughManager.start_game()

func handle_wave_complete(is_last_wave: bool):
	if is_last_wave:
		print("game over - victory")
		return
	
	print("wave ", PlaythroughManager.current_wave, " defeated. moving to build mode...")
	PlaythroughManager.game_state = Enums.GameState.BUILD

func request_next_wave():
	PlaythroughManager.game_state = Enums.GameState.BATTLE
	PlaythroughManager.current_wave += 1


func _on_request_spawn_projectile(
		projectile_scene: PackedScene,
		spawn_position: Vector2,
		direction: Vector2) -> void:
	var projectile: Bullet = projectile_scene.instantiate()
	projectile.global_position = spawn_position
	projectile.direction = direction
	projectile_container.add_child(projectile)
