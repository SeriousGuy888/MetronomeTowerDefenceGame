extends Sprite2D

@export var angles_to_watch_degrees: Array[int]

signal angle_passed(angle_in_degrees)

@onready var parent = $".."
var beats_per_minute
var beats_per_second
var angle_change_per_second # radians

func _ready():
	beats_per_minute = parent.beats_per_minute
	beats_per_second = 60 / beats_per_minute
	angle_change_per_second = (2 * PI) / beats_per_second

func _process(delta):
	var old_angle = int(rad_to_deg(rotation)) % 360
	rotation += angle_change_per_second * delta
	var new_angle = int(rad_to_deg(rotation)) % 360
	if new_angle < old_angle:
		old_angle -= 360 # to deal with when the playhead crosses 0°
	
	for angle in angles_to_watch_degrees:
		if old_angle < angle and angle < new_angle:
			angle_passed.emit(angle)
