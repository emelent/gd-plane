extends Node2D


signal score_changed

var player_speed = 150.0
var score = 0 setget set_score

const group = {
	bodies = "bodies"
}

func set_score(value):
	score = value
	emit_signal("score_changed", score)

func increment_score():
	score += 1
	emit_signal("score_changed", score)
