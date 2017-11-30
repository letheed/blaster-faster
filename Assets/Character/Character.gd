extends Area2D

signal hp_changed(new_hp)
signal died

export(int) var hp_full = 1

onready var rect = get_viewport_rect()
onready var anim = $AnimationPlayer
onready var extents = $Sprite.texture.get_size() / 2
onready var x_min = rect.position.x + extents.x
onready var x_max = rect.end.x - extents.x
onready var hp = hp_full setget set_hp

func set_hp(new_hp):
	var old_hp = hp
	hp = int(clamp(new_hp, 0, hp_full))
	if old_hp == null:
		return
	if hp != old_hp:
		emit_signal("hp_changed", hp)
	if hp <= 0 and not is_queued_for_deletion():
		emit_signal("died")
		on_died()
		queue_free()
		return
	if hp < old_hp:
		on_hit()

func on_hit():
	pass

func on_died():
	pass
