class_name Metronome extends Area2D

@export var beats_per_minute: float = 120 # float not int, for subsecond calculations
@export var beats_per_rotation = 4 # how many beats occur in a single rotation of the playhead
@export var turret_slot_manager: Node2D

func _ready():
	EventBus.restart_game.connect(reset)

func _process(_delta: float) -> void:
	# i don't know how to get the area_entered signal to work
	for area in get_overlapping_areas():
		if area is Enemy:
			PlaythroughManager.lives_remaining -= 1
			print("-1 life. new: ", PlaythroughManager.lives_remaining)
			area.die(false)

func reset():
	$TurretSlotManager.reset()
	$playhead.reset()

func get_turret_slot_global_position(lane: Enums.Lane):
	var slot: TurretSlot = $TurretSlotManager.slots.get(lane)
	if slot:
		return slot.global_position
	return null

func _on_playhead_angle_passed(lane: Enums.Lane) -> void:
	# angle is given as "degrees clockwise from north"
	turret_slot_manager.fire(lane)
