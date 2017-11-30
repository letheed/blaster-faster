extends Polygon2D

onready var anim = $AnimationPlayer

func _exit_tree():
	Effects.flash = null

func _ready():
	Effects.flash = self

func play():
	anim.play("Fade out")