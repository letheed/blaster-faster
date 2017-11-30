extends Sprite

func _ready():
	rotation = rand_range(-PI, PI)
	$AnimationPlayer.play("Explosion")
	$Flare.emitting = true
	$Smoke.emitting = true
