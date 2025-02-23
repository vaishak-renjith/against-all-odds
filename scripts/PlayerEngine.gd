extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const DASH_SPEED = 2000

var is_dashing = false
var can_dash = true
var dash_time = 1
var dash_cooldown = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.8
var can_double_jump = true

var opening = false

@export var transitionNode : Node2D

const lines : Array[String] = [
	"Hi, I'm dinger",
	"welcome to Against All Odds",
]

func _input(event):
	if DialogueManager.isDialogueActive:
		return
	if Input.is_key_pressed(KEY_Z):
		# play some animation
		print("Z pressed")
		if (levelWin() && !opening):
			opening = true
			print("BEFORE ", GameManager.cur_level)
			GameManager.cur_level = GameManager.cur_level + 1
			print("AFTER ", GameManager.cur_level)
			print("Level cleared!")
			for door in get_tree().get_nodes_in_group("doors"):
				door.get_child(0).play("level_win")
			await get_tree().create_timer(2.0).timeout
			if (GameManager.cur_level < 4):
				for node in get_tree().get_nodes_in_group("clones"):
					node.queue_free()
				transitionNode.set_visible(true)
				await get_tree().create_timer(1).timeout
				get_tree().change_scene_to_file("res://level"+str(GameManager.cur_level)+".tscn")
				opening = false
	if Input.is_key_pressed(KEY_X):
		DialogueManager.start_dialogue(global_position, lines)
		
	if Input.is_key_pressed(KEY_R):
		for node in get_tree().get_nodes_in_group("clones"):
			node.queue_free()
		get_tree().change_scene_to_file("res://level" + str(GameManager.cur_level) + ".tscn")
		
	if Input.is_key_pressed(KEY_C):
		clone()

func clone():
	#to-do: add timer and limit on how many clones you can place
	var scene = load("res://clone.tscn")
	var scene_instance = scene.instantiate()
	scene_instance.global_position = global_position
	print(scene_instance.global_position, global_position)
	scene_instance.modulate.a = 0.5
	scene_instance.play("default")
	scene_instance.add_to_group("clones")
	get_tree().root.add_child(scene_instance)
	

func levelWin():
	for door in get_tree().get_nodes_in_group("doors"):
		door.get_child(0).play("new_animation")
	for door in get_tree().get_nodes_in_group("doors"):
		if (!door.isViewable):
			return false
	return true
	
func _process(delta):
	var doors = 0
	for door in get_tree().get_nodes_in_group("doors"):
		if (door.isViewable):
			doors += 1
	get_child(6).get_child(6).get_child(0).text = str(doors) + "/" + str(get_tree().get_nodes_in_group("doors").size())
		
func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collision_block = collision.get_collider()
		if collision_block.is_in_group("Blocks"):
			collision_block.apply_central_impulse(collision.get_normal() * -20)
	move_and_slide()

func _on_dash_timer_timeout():
	can_dash = true
