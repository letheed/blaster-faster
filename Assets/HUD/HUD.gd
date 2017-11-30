extends Control

const Golden = preload("res://Share/Themes/Golden.tres")

func _ready():
	Game.connect("score_changed", self, "set_score")
	Game.connect("highscore_changed", self, "on_new_highscore")
	set_score(Game.score)

func set_hp(new_hp):
	$HP.frame = clamp(new_hp, 0, $HP.hframes - 1)

func set_score(new_score):
	$Score.set_score(new_score)

func on_new_highscore():
	Game.disconnect("highscore_changed", self, "on_new_highscore")
	$Score/Label.theme = Golden
