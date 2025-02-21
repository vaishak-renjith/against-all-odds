extends State
@export var Player : CharacterBody2D
var is_dashing = false

func Enter():
	Player.get_child(0).play("dinger_dash")
	is_dashing = true
	var timer = Player.get_child(4)
	timer.start()
	if (!(Player.get_child(0).flip_h)):
		Player.velocity = Vector2(400, 0)
	else:
		Player.velocity = Vector2(-400, 0)

	# Wait for the dash duration
	Player.can_dash = false
	await get_tree().create_timer(0.2).timeout
	is_dashing = false
	Transitioned.emit(self, "PlayerIdle")  # Transition back to the movement state

func Physics_Update(_delta):
	Player.move_and_slide()


