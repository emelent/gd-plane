extends Node2D


func _ready():
	Global.connect("score_changed", self, "__on_score_changed")
	pass


func __on_score_changed(new_score):
	$HUD/Score.text = "%d" % new_score
