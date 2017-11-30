extends Node2D

export(Texture) var texture
export(float) var speed

onready var tex_height = texture.get_height()
onready var vp_height = get_viewport_rect().size.y

var tile_count

func _ready():
	tile_count = ceil(vp_height / tex_height) + 1
	for i in range(tile_count):
		var sprite = Sprite.new()
		sprite.texture = texture
		sprite.centered = false
		sprite.position.y = i * tex_height
		add_child(sprite)

func _process(delta):
	var motion = speed * delta
	for child in get_children():
		var y = child.position.y + motion
		if y >= vp_height:
			y -= tile_count * tex_height
		child.position.y = y
