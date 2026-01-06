extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(body):
	game_manager.add_poin()
	animation_player.play("PickUp")
