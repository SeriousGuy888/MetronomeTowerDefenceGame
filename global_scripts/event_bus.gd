extends Node

@warning_ignore("unused_signal")
signal request_spawn_projectile(
	projectile_scene: PackedScene,
	spawn_position: Vector2, # global position
	direction: Vector2)

@warning_ignore("unused_signal")
signal request_spawn_enemy(enemy_scene: PackedScene)

@warning_ignore("unused_signal")
signal request_select_turret_slot(turret_slot: TurretSlot)

@warning_ignore("unused_signal")
signal make_turret_purchase(shop_item_id: String)

@warning_ignore("unused_signal")
signal request_add_coins(amount: int)

@warning_ignore("unused_signal")
signal coin_balance_updated(new_balance: int)
