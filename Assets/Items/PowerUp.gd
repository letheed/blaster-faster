extends Area2D

export(float) var speed = 200

enum Type {HEALTH = 0, DOUBLE_LASER = 1}

onready var sprite = $Sprite

var type = 0 setget set_type

func _ready():
	draw_type()

func _process(delta):
	global_position.y += speed * delta

func set_type(new_type):
	type = new_type
	sprite.frame = type

func draw_type():
	if randf() < 0.5:
		self.type = HEALTH
	else:
		self.type = DOUBLE_LASER

func on_area_entered(object):
	if object.is_in_group("Player"):
		match type:
			HEALTH:
				object.hp += 1
			DOUBLE_LASER:
				object.double_laser = true
		Effects.power_up_sound.play()
		queue_free()
