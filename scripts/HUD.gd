extends Control

var score := 0 setget set_score

onready var score_label: Label = $ScoreLabel

func set_score(value: int) -> void:
  score_label.text = "Score: %d" % value
  score = value
