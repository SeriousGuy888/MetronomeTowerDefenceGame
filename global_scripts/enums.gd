extends Node

enum GameState {
	BATTLE = 0, # monsters approach, turrets fire
	BUILD = 1, # time to build and upgrade setup. no monsters approach.
	GAME_OVER = 2,
}

enum Lane {
	TOP = 270,
	TOP_RIGHT = 315,
	RIGHT = 0,
	BOTTOM_RIGHT = 45,
	BOTTOM = 90,
	BOTTOM_LEFT = 135,
	LEFT = 180,
	TOP_LEFT = 225,
}
