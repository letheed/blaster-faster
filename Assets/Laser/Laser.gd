extends Area2D

export(Vector2) var velocity
export(String) var target_group

func _ready():
	if not get_viewport_rect().has_point(global_position):
		queue_free()

func _process(delta):
	global_position += velocity * delta

func on_area_entered(object):
	if object.is_in_group(target_group):
		object.hp -= 1
		Effects.spawn_flare(global_position)
		queue_free()
