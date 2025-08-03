class_name ShinyFrisbee extends Projectile

const SHINY_FRISBEE = preload("res://scenes/projectiles/shiny_frisbee.tscn")
const NEIGHBOURING_LANES := {
	Enums.Lane.TOP: [Enums.Lane.TOP_LEFT, Enums.Lane.TOP_RIGHT],
	Enums.Lane.TOP_RIGHT: [Enums.Lane.TOP, Enums.Lane.RIGHT],
	Enums.Lane.RIGHT: [Enums.Lane.TOP_RIGHT, Enums.Lane.BOTTOM_RIGHT],
	Enums.Lane.BOTTOM_RIGHT: [Enums.Lane.RIGHT, Enums.Lane.BOTTOM],
	Enums.Lane.BOTTOM: [Enums.Lane.BOTTOM_RIGHT, Enums.Lane.BOTTOM_LEFT],
	Enums.Lane.BOTTOM_LEFT: [Enums.Lane.BOTTOM, Enums.Lane.LEFT],
	Enums.Lane.LEFT: [Enums.Lane.BOTTOM_LEFT, Enums.Lane.TOP_LEFT],
	Enums.Lane.TOP_LEFT: [Enums.Lane.LEFT, Enums.Lane.TOP],
}

var lane: Enums.Lane
var should_split = true # if set to true, will spawn 2 more of itself
var should_split_into_neighbouring_lanes = false # if false, spawns new copies in own lane
var speed = 250

var direction: Vector2:
	get: return direction
	set(value): direction = value.normalized()

func _ready() -> void:
	super()
	direction = Vector2.from_angle(deg_to_rad(lane))
	
	if should_split:
		should_split = false
		if should_split_into_neighbouring_lanes:
			for neighbouring_lane in NEIGHBOURING_LANES[lane]:
				EventBus.request_spawn_shiny_frisbee_in_lane.emit(neighbouring_lane)
		else:
			EventBus.request_spawn_shiny_frisbee_in_lane.emit(lane)
			EventBus.request_spawn_shiny_frisbee_in_lane.emit(lane)

func _process(delta) -> void:
	super(delta)
	position += direction * speed * delta
