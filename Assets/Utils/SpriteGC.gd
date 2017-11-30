extends VisibilityNotifier2D

func _ready():
	var parent = get_parent()
	var size = parent.get_node("Sprite").texture.get_size()
	rect = Rect2(-size.x / 2, -size.y / 2, size.x, size.y)
	connect("screen_exited", parent, "queue_free")
