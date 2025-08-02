class_name EnemyType
extends Resource

@export var enemy_type: Enums.EnemyType = Enums.EnemyType.BASIC
@export var texture: Texture2D
@export var name: String = "Unnamed Enemy"
@export var base_health: int = 1
@export var base_speed: float = 50.0
@export var coins_dropped: int = 3
@export var is_boss: bool = false

# Damage resistance multipliers (1.0 = normal damage, 0.5 = half damage, 2.0 = double damage)
@export var percussion_resistance: float = 1.0 # Drums
@export var wind_resistance: float = 1.0 # Wind instruments
@export var string_resistance: float = 1.0 # String instruments
@export var cymbal_resistance: float = 1.0 # Cymbals
@export var special_resistance: float = 1.0 # Special instruments

func get_damage_multiplier(turret_damage_type: Enums.TurretDamageType) -> float:
	match turret_damage_type:
		Enums.TurretDamageType.PERCUSSION:
			return percussion_resistance
		Enums.TurretDamageType.WIND:
			return wind_resistance
		Enums.TurretDamageType.STRING:
			return string_resistance
		Enums.TurretDamageType.CYMBAL:
			return cymbal_resistance
		Enums.TurretDamageType.SPECIAL:
			return special_resistance
		_:
			return 1.0
