extends Node

enum GameState {
	BATTLE = 0, # monsters approach, turrets fire
	BUILD = 1, # time to build and upgrade setup. no monsters approach.
	GAME_OVER = 2,
}

enum EnemyType {
	BASIC = 0,
	FAST = 1,
	TANK = 2,
	ARMORED = 3,
	FLYING = 4,
	BOSS = 5,
}

enum TurretDamageType {
	PERCUSSION = 0,  # Drums, strong vs basic enemies
	WIND = 1,        # Flutes, strong vs flying enemies
	STRING = 2,      # Guitar, balanced damage
	CYMBAL = 3,      # Cymbals, strong vs armored enemies
	SPECIAL = 4,     # Other instruments, unique effects
}
