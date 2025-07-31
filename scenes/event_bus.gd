extends Node

@warning_ignore("unused_signal")
signal request_spawn_projectile(
	projectile_scene: PackedScene,
	spawn_position: Vector2, # global position
	direction: Vector2)
