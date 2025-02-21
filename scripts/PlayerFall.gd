extends State
class_name PlayerFall

@export var Player : CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction
	
func Enter():
	Player.get_child(0).play("dinger_fall")

func Physics_Update(_delta : float):
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		Player.velocity.x = direction * Player.SPEED * 0.75
	else:
		Player.velocity.x = move_toward(Player.velocity.x, 0, Player.SPEED * 0.75)
	
	if Input.is_action_just_pressed("ui_accept") && Player.can_double_jump:
			Player.velocity.y = Player.JUMP_VELOCITY
			Player.can_double_jump = false
	
	if not Player.is_on_floor():
		Player.velocity.y += gravity * _delta
	elif Input.is_key_pressed(KEY_SHIFT) && Player.can_dash:
		Transitioned.emit(self, "playerdash")
	elif Player.is_on_floor():
		Player.can_double_jump = true
		Transitioned.emit(self, "playeridle")
