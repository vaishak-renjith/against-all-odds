extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_viewport_rect().size)
	# get_window().unresizable = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
