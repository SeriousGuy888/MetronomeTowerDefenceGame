class_name Metronome extends Area2D

@export var beats_per_minute: float = 120 # float not int, for subsecond calculations
@export var beats_per_rotation = 4 # how many beats occur in a single rotation of the playhead
@export var turret_slot_manager: Node2D

@onready var timer: Timer = $Timer

var tick = 0

func _ready():
	timer.wait_time = 60 / beats_per_minute
	timer.start()

func _process(_delta: float) -> void:
	# i don't know how to get the area_entered signal to work
	for area in get_overlapping_areas():
		if area is Enemy:
			PlaythroughManager.lives_remaining -= 1
			print("-1 life. new: ", PlaythroughManager.lives_remaining)
			area.die(false)

func _on_timer_timeout() -> void:
	tick += 1
	timer.start()


func _on_playhead_angle_passed(angle_in_degrees: Variant) -> void:
	# angle is given as "degrees clockwise from north"
	turret_slot_manager.fire(angle_in_degrees)
