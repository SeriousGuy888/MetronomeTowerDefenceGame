extends Node

signal request_spawn_projectile(
	projectile_scene: PackedScene,
	spawn_position: Vector2, # global position
	direction: Vector2)


signal request_spawn_enemy(enemy_scene: PackedScene)
