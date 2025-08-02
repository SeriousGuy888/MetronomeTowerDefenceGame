extends Node

@warning_ignore_start("unused_signal")

signal request_add_projectile_to_scene( # New version
	projectile_instance: Projectile,
	spawn_position: Vector2) # global position
signal request_spawn_enemy_type(enemy_type: Enums.EnemyType, wave_index: int)

signal request_select_turret_slot(turret_slot: TurretSlot)
signal make_turret_purchase(turret_type: TurretType)
signal turret_slot_turret_updated(turret_slot: TurretSlot)

signal request_add_coins(amount: int)

signal game_state_updated(new_game_state: Enums.GameState)
signal lives_remaining_updated(new_number: int)
signal current_wave_updated(new_wave: int)
signal coin_balance_updated(new_balance: int)

signal wave_complete(is_last_wave: bool)
signal enemy_from_wave_died(wave_index: int) # When an enemy part of some wave dies.
signal request_next_wave
