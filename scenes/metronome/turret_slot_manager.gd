extends Node

@export var turret_slot_scene: PackedScene
@export var radius = 86

var slots: Dictionary = {}

func _ready():
	spawn_turret_slots()

func spawn_turret_slots():
	for angle_deg in Enums.Lane.values():
		var angle = Vector2.from_angle(deg_to_rad(angle_deg))
		var slot: Node2D = turret_slot_scene.instantiate()
		slot.position = angle * radius
		slot.lane = angle_deg
		add_child(slot)
		slots[angle_deg] = slot

func fire(lane: Enums.Lane):
	var slot = slots.get(lane)
	if !slot:
		push_warning("Attempted to fire turret in lane ", lane, "°, but no such slot exists.")
		return
	
	slot.fire()

func reset():
	for lane in slots:
		var slot: TurretSlot = slots[lane]
		slot.remove_turret()
