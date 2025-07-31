extends Node

@onready var coin_amount_label: Label = %CoinAmount

var coins: int = 0:
	get:
		return coins
	set(new_amount):
		coins = new_amount
		if coin_amount_label:
			coin_amount_label.text = str(coins)


func _on_givecoinbutton_pressed() -> void:
	coins += 1
