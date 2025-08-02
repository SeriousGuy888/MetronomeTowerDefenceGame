extends PanelContainer

const TURRET = preload("res://scenes/turrets/turret.tscn")
const NO_TURRET = preload("res://resources/turrets/no_turret.tres")

# When a player clicks on a turret slot, the shop should change to reflect
# the current state of the selected slot.
# If null, the shop should hide itself.
var selected_slot: TurretSlot:
	get:
		return selected_slot
	set(new_slot):
		selected_slot = new_slot
		visible = !!selected_slot
		if selected_slot:
			update_offerings()

func _ready() -> void:
	selected_slot = null
	EventBus.request_select_turret_slot.connect(func(new_slot): selected_slot = new_slot)
	EventBus.make_turret_purchase.connect(_on_turret_purchase)
	EventBus.turret_slot_turret_updated.connect(func(slot):
		if slot == selected_slot:
			update_offerings()
	)

func update_offerings():
	var current_turret = selected_slot.turret
	var current_turret_type: TurretType = current_turret.turret_type \
		if current_turret \
		else NO_TURRET
	
	var offerings = current_turret_type.upgrades_to
	
	# Given the list of possible purchases, update the slots to display the possible purchases
	# to the user. If there are more shop slots than offerings available, make the extra slots
	# invisible.
	var offering_idx = 0
	for turret_shop_item: TurretShopItem in %OfferingsContainer.get_children():
		if offering_idx < len(offerings):
			turret_shop_item.turret_type = offerings[offering_idx]
			turret_shop_item.visible = true
		else:
			turret_shop_item.visible = false
		offering_idx += 1
	if offering_idx < len(offerings):
		push_warning("not enough slots to display ", len(offerings), " offers in shop")
		# could make it automatically make more slots, but not worth it for this game jam game

func _on_turret_purchase(turret_type: TurretType) -> void:
	if !selected_slot:
		return
	
	if turret_type == null:
		selected_slot.remove_turret()
		return
	
	selected_slot.place_turret(TURRET, turret_type)

func _on_close_button_pressed() -> void:
	selected_slot = null
