extends Node

var score = 0

@onready var coin_label: Label = $Coin
@onready var hud_scene = %HUD

func add_poin():
	score += 1
	coin_label.text = "You Collected: " + str(score)
	hud_scene.update_score_text(score)
