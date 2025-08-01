extends Node

var coins: int = 10:
	get:
		return coins
	set(new_amount):
		coins = new_amount
		EventBus.coin_balance_updated.emit(coins)

func _ready() -> void:
	EventBus.request_add_coins.connect(func(amount): coins += amount)

func _on_givecoinbutton_pressed() -> void:
	coins += 1
