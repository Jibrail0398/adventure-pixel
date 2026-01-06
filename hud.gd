extends CanvasLayer

@onready var score_label: Label = $ScoreLabel

func update_score_text(score_baru):
	score_label.text = "Score: " + str(score_baru)
	
