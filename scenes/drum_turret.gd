extends Turret

@export var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

func fire(direction: Vector2):
	EventBus.request_spawn_projectile.emit(bullet_scene, global_position, direction)
