extends PanelContainer

func _ready() -> void:
	update_visibility(PlaythroughManager.game_state)
	EventBus.game_state_updated.connect(update_visibility)
	
func update_visibility(game_state: Enums.GameState):
	visible = game_state == Enums.GameState.GAME_OVER


func _on_play_again_pressed() -> void:
	EventBus.restart_game.emit()
