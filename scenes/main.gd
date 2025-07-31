extends Node2D

@export var bullet_scene: PackedScene = preload("res://scenes/bullet.tscn")

@onready var projectile_container: Node = $ProjectileContainer
@onready var enemy_container: Node = $EnemyContainer


func _on_metronome_request_launch_projectile(direction: Vector2) -> void:
	var bullet: Bullet = bullet_scene.instantiate()
	bullet.direction = direction
	bullet.translate(direction * 10)
	projectile_container.add_child(bullet)
	
