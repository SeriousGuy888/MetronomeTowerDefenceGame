extends Node

enum GameState {
	BATTLE = 0, # monsters approach, turrets fire
	BUILD = 1, # time to build and upgrade setup. no monsters approach.
	GAME_OVER = 2,
}
