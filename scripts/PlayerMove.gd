extends State
class_name PlayerMove

@export var Player : CharacterBody2D
var direction : float

func Enter():
	if DialogueManager.isDialogueActive:
		return
	Player.get_child(0).play("dinger_walk")

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	if DialogueManager.isDialogueActive:
		return
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		Player.velocity.x = direction * Player.SPEED
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED)
		
	if direction == -1:
		Player.get_child(0).flip_h = true;
	if direction == 1:
		Player.get_child(0).flip_h = false;
	
	if Player.velocity.x == 0:
		Transitioned.emit(self, "PlayerIdle")
	elif (Player.is_on_floor() && Input.is_action_just_pressed("ui_accept")):
		Transitioned.emit(self, "PlayerJump")
	elif Input.is_key_pressed(KEY_SHIFT) && Player.can_dash:
		Transitioned.emit(self, "playerdash")
	elif (!Player.is_on_floor()):
		Transitioned.emit(self, "PlayerFall")
