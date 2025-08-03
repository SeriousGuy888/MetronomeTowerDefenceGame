extends Node

var game_state: Enums.GameState = Enums.GameState.BATTLE:
	get: return game_state
	set(new_state):
		game_state = new_state
		EventBus.game_state_updated.emit(game_state)
var lives_remaining: int = 5:
	get: return lives_remaining
	set(new_amount):
		lives_remaining = new_amount
		EventBus.lives_remaining_updated.emit(lives_remaining)
		if lives_remaining <= 0:
			lose()
var current_wave = 0:
	get: return current_wave
	set(new_wave):
		current_wave = new_wave
		EventBus.current_wave_updated.emit(current_wave)
var coins: int = 10:
	get: return coins
	set(new_amount):
		coins = new_amount
		EventBus.coin_balance_updated.emit(coins)
var enemies_slain = 0

func _ready() -> void:
	EventBus.request_add_coins.connect(func(amount): coins += amount)
	EventBus.restart_game.connect(restart_game)

func start_game():
	coins = 10
	current_wave = 0
	lives_remaining = 5
	game_state = Enums.GameState.BATTLE
	enemies_slain = 0

func restart_game():
	var existing_enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in existing_enemies:
		enemy.queue_free()
	
	start_game()

func lose():
	print("game over - defeat")
	game_state = Enums.GameState.GAME_OVER
