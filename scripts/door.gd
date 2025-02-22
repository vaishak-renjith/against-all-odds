extends Toggleable

@onready var visibility_notifier = $VisibileOnScreenNotifier2D 
var isViewable : bool = false
var isViewedByClone : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	print("door became visible")
	isViewable = true

func _on_visible_on_screen_notifier_2d_screen_exited():
	if isViewedByClone:
		return
	print("door out of sight")
	isViewable = false
