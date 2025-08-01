extends Sprite2D

@export var angles_to_watch_degrees: Array[int]

signal angle_passed(angle_in_degrees)

var beats_per_minute
var beats_per_second
var beats_per_rotation
var angle_change_per_second # radians

var is_spinning = false

func _ready():
	beats_per_minute = get_parent().beats_per_minute
	beats_per_rotation = get_parent().beats_per_rotation
	beats_per_second = 60 / beats_per_minute
	angle_change_per_second = TAU / beats_per_second / beats_per_rotation
	
	EventBus.game_state_updated.connect(func(new_state: Enums.GameState):
		is_spinning = new_state == Enums.GameState.BATTLE)

func _process(delta):
	if !is_spinning:
		return
	
	var old_angle = int(rad_to_deg(rotation)) % 360
	rotation += angle_change_per_second * delta
	var new_angle = int(rad_to_deg(rotation)) % 360
	if new_angle < old_angle:
		old_angle -= 360 # to deal with when the playhead crosses 0°
	
	for watched_angle in angles_to_watch_degrees:
		if old_angle < watched_angle and watched_angle <= new_angle:
			# rotate to be number of degrees clockwise from north
			angle_passed.emit((watched_angle + 270) % 360)
