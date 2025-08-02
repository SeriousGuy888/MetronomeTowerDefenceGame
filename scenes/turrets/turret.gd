class_name Turret extends Node2D

@export var turret_type: TurretType

func _ready() -> void:
	if !turret_type:
		push_warning(self.name + " has no turret type defined.")
		return
	
	$Sprite.texture = turret_type.texture

func fire(direction: Vector2):
	if turret_type.projectile_scene:
		EventBus.request_spawn_projectile.emit(turret_type.projectile_scene, global_position, direction)
