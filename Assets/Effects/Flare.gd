extends Sprite

export(bool) var one_shot = true

onready var anim = $AnimationPlayer

func _ready():
	if one_shot:
		anim.connect("animation_finished", self, "queue_free1")
		play()

func play():
	anim.play("Fade out")

func queue_free1(_arg):
	queue_free()
