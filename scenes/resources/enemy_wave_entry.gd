class_name EnemyWaveEntry
extends Resource

@export var enemy_scene: PackedScene
@export var enemy_type: Enums.EnemyType = Enums.EnemyType.BASIC # New: specify enemy type
@export var count: int = 1
@export var spawn_weight: float = 1.0 # Higher weight = more likely to spawn first
