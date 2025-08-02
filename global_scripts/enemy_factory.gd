class_name EnemyFactory
extends Node

# Single enemy scene that can be configured
const ENEMY_SCENE = preload("res://scenes/enemies/enemy.tscn")

# Enemy type resources
const BASIC_ENEMY_TYPE = preload("res://resources/enemies/basic_enemy.tres")
const FAST_ENEMY_TYPE = preload("res://resources/enemies/fast_enemy.tres")
const TANK_ENEMY_TYPE = preload("res://resources/enemies/tank_enemy.tres")
const ARMORED_ENEMY_TYPE = preload("res://resources/enemies/armored_enemy.tres")
const FLYING_ENEMY_TYPE = preload("res://resources/enemies/flying_enemy.tres")
const BOSS_ENEMY_TYPE = preload("res://resources/enemies/boss_enemy.tres")

static func create_enemy(enemy_type: Enums.EnemyType) -> Enemy:
	var enemy_instance: Enemy = ENEMY_SCENE.instantiate()
	var enemy_type_resource: EnemyType = get_enemy_type_resource(enemy_type)
	
	# Configure the enemy with the appropriate type
	enemy_instance.enemy_type = enemy_type_resource
	
	return enemy_instance

static func get_enemy_type_resource(enemy_type: Enums.EnemyType) -> EnemyType:
	match enemy_type:
		Enums.EnemyType.BASIC:
			return BASIC_ENEMY_TYPE
		Enums.EnemyType.FAST:
			return FAST_ENEMY_TYPE
		Enums.EnemyType.TANK:
			return TANK_ENEMY_TYPE
		Enums.EnemyType.ARMORED:
			return ARMORED_ENEMY_TYPE
		Enums.EnemyType.FLYING:
			return FLYING_ENEMY_TYPE
		Enums.EnemyType.BOSS:
			return BOSS_ENEMY_TYPE
		_:
			return BASIC_ENEMY_TYPE
