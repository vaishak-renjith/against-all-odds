extends Toggleable

@onready var visibility_notifier = $VisibileOnScreenNotifier2D 
var isViewable : bool = false
var isViewedByClone : bool = false
@export var init_toggled : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	toggled = init_toggled

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if toggled:
		isViewable = get_child(1).is_on_screen()
	else:
		isViewable = false
	if toggled:
		get_child(0).modulate.a = 1
	else:
		get_child(0).modulate.a = 0


func _on_visible_on_screen_notifier_2d_screen_entered():
	print("door became visible")
	if toggled:
		isViewable = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	if isViewedByClone:
		return
	print("door out of sight")
	isViewable = false
