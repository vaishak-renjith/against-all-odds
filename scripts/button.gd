extends Area2D

@export var pair : Toggleable
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pressed = has_overlapping_bodies()
	pair.toggled = pressed
	#print(pair.toggled)
	
	
