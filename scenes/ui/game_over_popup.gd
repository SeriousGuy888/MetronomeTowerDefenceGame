extends PanelContainer

@onready var game_over_stats: Label = $MarginContainer/VBoxContainer/GameOverStats

func _ready() -> void:
	update_display(PlaythroughManager.game_state)
	EventBus.game_state_updated.connect(update_display)
	
func update_display(game_state: Enums.GameState):
	visible = game_state == Enums.GameState.GAME_OVER
	
	game_over_stats.text = \
		"Survived to Wave " + str(PlaythroughManager.current_wave + 1) + ".\n" + \
		str(PlaythroughManager.enemies_slain) + " enemies slain."


func _on_play_again_pressed() -> void:
	EventBus.restart_game.emit()
