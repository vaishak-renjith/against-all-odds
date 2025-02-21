extends State
class_name PlayerJump

@export var Player : CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

func Enter():
	Player.get_child(0).play("dinger_jump")
	Player.velocity.y = Player.JUMP_VELOCITY

func Physics_Update(_delta : float):
	direction = Input.get_axis("ui_left", "ui_right")
	var vely = Player.velocity.y
	#print (vely)
	if direction:
		Player.velocity.x = direction * Player.SPEED * 0.75
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED * 0.75)
	
	if not Player.is_on_floor():
		Player.velocity.y += gravity * _delta
		if Input.is_action_just_pressed("ui_accept") && Player.can_double_jump:
			Player.velocity.y = Player.JUMP_VELOCITY
			Player.can_double_jump = false
	
	if Player.is_on_floor():
		Player.can_double_jump = true
		Transitioned.emit(self, "playeridle")
	elif Input.is_key_pressed(KEY_SHIFT) && Player.can_dash:
		Transitioned.emit(self, "playerdash")
	elif Player.velocity.y > 0:
		Transitioned.emit(self, "playerfall")
