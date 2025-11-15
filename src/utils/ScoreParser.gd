extends Node
class_name ScoreParser

func parse(score: int, lenght: int):
	var score_len = str(score).length()
	var score_label = ""
	
	for l in (lenght - score_len):
		score_label += "0"
		
	score_label += str(score)
	
	return score_label
