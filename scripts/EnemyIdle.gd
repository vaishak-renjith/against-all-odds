extends EnemyState
class_name EnemyIdle
var direction : float
var offset : float = 10

func Enter():
	Enemy.get_child(0).play("default")

func Update(_delta : float):
	pass

func Physics_Update(_delta : float):
	if (Player.global_position.x + offset < Enemy.global_position.x) or (Player.global_position.x - offset > Enemy.global_position.x):
		print("SDFJLKDJFSLDFJLKJ")
		Transitioned.emit(self, "EnemyMove")
