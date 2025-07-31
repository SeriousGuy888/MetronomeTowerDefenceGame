extends RigidBody2D

@export var beats_per_minute: float = 120 # float not int, for subsecond calculations

@onready var timer: Timer = $Timer

signal request_launch_projectile(direction: Vector2)

var tick = 0

func _ready():
	timer.wait_time = 60 / beats_per_minute
	timer.start()

func _on_timer_timeout() -> void:
	tick += 1
	timer.start()

func fire_bullet(direction: Vector2):
	request_launch_projectile.emit(direction)


func _on_playhead_angle_passed(angle_in_degrees: Variant) -> void:
	# angle is given as "degrees clockwise from north"
	var angle = deg_to_rad(angle_in_degrees)
	var direction = Vector2(sin(angle), -cos(angle))
	fire_bullet(direction)
	#print(angle_in_degrees, direction)
