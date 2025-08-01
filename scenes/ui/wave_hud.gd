extends PanelContainer


func _ready() -> void:
	update_wave_counter(PlaythroughManager.current_wave)
	EventBus.current_wave_updated.connect(update_wave_counter)
	EventBus.game_state_updated.connect(handle_game_state_change)

func update_wave_counter(new_wave: int):
	%CurrentWave.text = "Wave " + str(new_wave)

func handle_game_state_change(new_state: Enums.GameState):
	print(new_state)
	%NextWaveButton.visible = (new_state == Enums.GameState.BUILD)
	%GameState.text = Enums.GameState.keys()[new_state]

func _on_next_wave_button_pressed() -> void:
	EventBus.request_next_wave.emit()
