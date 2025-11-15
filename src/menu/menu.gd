extends Node2D

signal start_game

func _ready() -> void:
	var score = GameStorage.new().get_score()
	
	if (score):
		var score_label = ScoreParser.new().parse(score, GameSettings.new().ScoreLength)
		$Label.text = "Ultimo Score: " + score_label
		
	else:
		$Label.visible = false


func _on_button__on_press() -> void:
	start_game.emit()
