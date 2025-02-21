extends EnemyState
class_name EnemyMove
var direction : float
var offset : float

func Enter():
	Enemy.get_child(0).play("goblin_walk")

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	if (Player.global_position.x + offset < Enemy.global_position.x):
		Enemy.velocity.x = -1 * Enemy.SPEED
		Enemy.get_child(0).flip_h = true
	if (Player.global_position.x - offset > Enemy.global_position.x):
		Enemy.velocity.x = 1 * Enemy.SPEED
		Enemy.get_child(0).flip_h = false
	
	if not Enemy.is_on_floor():
		Enemy.velocity.y += Enemy.gravity * _delta
