extends Node

@export var turret_slot_scene: PackedScene
@export var angles_to_place_turrets_at: Array[int] = [
	0, 45, 90, 135, 180, 225, 270, 315
]
@export var radius = 100

func _ready():
	spawn_turret_slots()

func spawn_turret_slots():
	for angle_deg in angles_to_place_turrets_at:
		var angle = Vector2.from_angle(deg_to_rad(angle_deg))
		var slot: Node2D = turret_slot_scene.instantiate()
		slot.position = angle * radius
		add_child(slot)
