extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var score = GameStorage.new().get_score()
	
	if (score):
		var score_label = ScoreParser.new().parse(score, GameSettings.new().ScoreLength)
		$Label.text = "Ultimo Score: " + score_label
		
	else:
		$Label.visible = false
