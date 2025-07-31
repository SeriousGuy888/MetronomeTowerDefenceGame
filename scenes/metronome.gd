extends RigidBody2D

@export var beats_per_minute: float = 120 # float not int, for subsecond calculations
@export var turret_slot_manager: Node2D

@onready var timer: Timer = $Timer

var tick = 0

func _ready():
	timer.wait_time = 60 / beats_per_minute
	timer.start()

func _on_timer_timeout() -> void:
	tick += 1
	timer.start()


func _on_playhead_angle_passed(angle_in_degrees: Variant) -> void:
	# angle is given as "degrees clockwise from north"
	turret_slot_manager.fire(angle_in_degrees)
