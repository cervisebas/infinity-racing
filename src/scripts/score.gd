extends Node2D

@export var score = 0
@export var letters = GameSettings.ScoreLength
@export var running = true


func _process(_delta: float) -> void:
	$Label.text = ScoreParser.new().parse(score, letters)

func _on_score_timer_timeout() -> void:
	if (running):
		score += 1
		
func save_score():
	GameStorage.new().save_score(score)

func reset():
	score = 0
