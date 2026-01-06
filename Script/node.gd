extends Node

var score = 0

@onready var coin_label: Label = $Coin

func add_poin():
	score += 1
	coin_label.text = "You Collected: " + str(score)
