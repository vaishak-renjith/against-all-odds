extends State
class_name PlayerIdle

@export var Player : CharacterBody2D

func Enter():
	get_viewport().get_visible_rect().size
	Player.get_child(0).play("dinger_idle")

func Update(_delta : float):
	var direction = Input.get_axis("ui_left", "ui_right")
	if (direction):
		Transitioned.emit(self, "PlayerMove")
	elif (Player.is_on_floor() && Input.is_action_just_pressed("ui_accept")):
		Transitioned.emit(self, "PlayerJump")
	elif (!Player.is_on_floor()):
		Transitioned.emit(self, "PlayerFall")
