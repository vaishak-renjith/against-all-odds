extends Label

var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += 1
	if timer >= 20:
		set_visible(!is_visible_in_tree())
		timer = 0

func _input(event):
	if Input.is_key_pressed(KEY_Z):
		get_tree().change_scene_to_file("res://level" + str(GameManager.cur_level) + ".tscn")


