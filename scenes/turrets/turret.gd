class_name Turret extends Node2D

@export var turret_type: TurretType

func _ready() -> void:
	if !turret_type:
		push_warning(self.name + " has no turret type defined.")
		return
	
	$Sprite.texture = turret_type.texture

func fire(lane: Enums.Lane):
	var projectile = turret_type.create_projectile_instance(lane)
	if projectile:
		EventBus.request_add_projectile_to_scene.emit(projectile, global_position)
