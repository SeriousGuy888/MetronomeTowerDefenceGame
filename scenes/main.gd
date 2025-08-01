extends Node2D

@onready var projectile_container: Node = $ProjectileContainer
@onready var enemy_container: Node = $EnemyContainer

func _ready() -> void:
	EventBus.request_spawn_projectile.connect(_on_request_spawn_projectile)

func _on_request_spawn_projectile(
		projectile_scene: PackedScene,
		spawn_position: Vector2,
		direction: Vector2) -> void:
	var projectile: Bullet = projectile_scene.instantiate()
	projectile.global_position = spawn_position
	projectile.direction = direction
	projectile_container.add_child(projectile)
