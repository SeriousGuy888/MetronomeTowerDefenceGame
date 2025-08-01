extends HBoxContainer

@export var heart_scene: PackedScene

func _ready() -> void:
	update_lives(PlaythroughManager.lives_remaining)
	EventBus.lives_remaining_updated.connect(update_lives)
	
func update_lives(number_of_lives: int):
	var currently_have = 0
	for child in get_children():
		if currently_have >= number_of_lives:
			child.queue_free()
		else:
			currently_have += 1
	
	if currently_have < number_of_lives:
		for i in range(PlaythroughManager.lives_remaining - currently_have):
			add_child(heart_scene.instantiate())
