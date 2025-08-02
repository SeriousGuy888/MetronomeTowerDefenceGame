@tool
class_name TurretShopItem
extends Panel

@onready var picture_rect: TextureRect = %Picture
@onready var title_label: Label = %Title
@onready var price_label: Label = %Price
@onready var purchase_button: Button = %PurchaseButton

@export var turret_type: TurretType:
	get: return turret_type
	set(new_value):
		turret_type = new_value
		update_shop_display()

var price: int:
	get:
		if turret_type:
			return turret_type.price
		return 0

func _ready() -> void:
	if !Engine.is_editor_hint(): # only when in game,
		update_affordability(PlaythroughManager.coins)
		update_shop_display()
		EventBus.coin_balance_updated.connect(update_affordability)

func update_shop_display():
	if picture_rect:
		picture_rect.texture = turret_type.texture
	if title_label:
		title_label.text = turret_type.name
	if price_label:
		price_label.text = str(price) + " coins"

func update_affordability(current_balance: int = 0):
	purchase_button.disabled = current_balance < price
	
	if current_balance < price:
		set_modulate(Color.DARK_GRAY)
	else:
		set_modulate(Color.WHITE)

func _on_purchase_button_pressed() -> void:
	if PlaythroughManager.coins >= price:
		PlaythroughManager.coins -= price
		EventBus.make_turret_purchase.emit(turret_type)
