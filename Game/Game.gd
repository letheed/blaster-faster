extends Node

signal score_changed(new_score)
signal highscore_changed

onready var soundtrack = $Soundtrack

const DATA_FILE_PATH = "user://game.ini"
const DATA_SECTION_GAME = "Game.v1"
const DATA_KEY_HIGHSCORE = "highscore"

var data = ConfigFile.new()
var data_changed = false
var score = 0 setget set_score
var highscore setget set_highscore, get_highscore

func _enter_tree():
	randomize()

func _exit_tree():
	save_data_file()

func _ready():
	load_data()

func set_score(new_score):
	score = new_score
	emit_signal("score_changed", score)
	update_highscore()

func set_highscore(new_highscore):
	data.set_value(DATA_SECTION_GAME, DATA_KEY_HIGHSCORE, new_highscore)
	data_changed = true
	emit_signal("highscore_changed")

func get_highscore():
	return data.get_value(DATA_SECTION_GAME, DATA_KEY_HIGHSCORE, 0)

func update_highscore():
	if score > self.highscore:
		self.highscore = score

func load_data():
	if file_exists(DATA_FILE_PATH):
		load_data_file()

func save_data():
	if data_changed:
		save_data_file()
		data_changed = false

func load_data_file():
	match data.load(DATA_FILE_PATH):
		OK: pass
		var error: printerr("load_data_file: error %s" % error)

func save_data_file():
	match data.save(DATA_FILE_PATH):
		OK: pass
		var error: printerr("save_data_file: error %s" % error)

func file_exists(file_path):
	return File.new().file_exists(file_path)

func quit():
	get_tree().quit()
