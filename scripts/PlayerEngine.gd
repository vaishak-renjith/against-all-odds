extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 2000
var cur_level = 1

var is_dashing = false
var can_dash = true
var dash_time = 1
var dash_cooldown = 0.5


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_double_jump = true

const lines : Array[String] = [
	"Hi, I'm dinger",
	"welcome to Against All Odds",
]

func _input(event):
	if Input.is_key_pressed(KEY_Z):
		# play some animation
		print("Z pressed")
		if (levelWin()):
			print("Level cleared!")
			get_tree().change_scene_to_file("res://level2.tscn")
		
		print(global_position.x, global_position.y)
	if Input.is_key_pressed(KEY_X):
		DialogueManager.start_dialogue(global_position, lines)

func levelWin():
	for door in get_tree().get_nodes_in_group("doors"):
		door.play("new_animation")
	for door in get_tree().get_nodes_in_group("doors"):
		if (!door.isViewable):
			return false
	return true
		
func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_block = collision.get_collider()
		if collision_block.is_in_group("Blocks"):
			collision_block.apply_central_impulse(collision.get_normal() * -1.1)
	move_and_slide()


func _on_dash_timer_timeout():
	can_dash = true
