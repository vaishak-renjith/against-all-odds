extends State
class_name EnemyState

@export var Enemy : CharacterBody2D
var Player : CharacterBody2D

func _ready():
	Player = get_tree().get_nodes_in_group("players")[0]

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass


