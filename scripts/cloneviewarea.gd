extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", _on_area_entered)


func _on_area_entered(area):
	print("area entered")
	if area.get_parent().is_in_group("doors"):
		area.get_parent().isViewedByClone = true
		area.get_parent().isViewable = true

func _on_area_exited(area: Area2D) -> void:
	print("area exited")
	if area.get_parent().is_in_group("doors"):
		area.get_parent().isViewedByClone = false
		area.get_parent().isViewable = false
