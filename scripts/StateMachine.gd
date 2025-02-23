extends Node
class_name StateMachine
#colon specifies var type
var current_state : State
var states : Dictionary = {}
@export var initial_state : State

func _ready():
	#loop through all children
	for child in get_children():
		#if a child is a state
		if child is State:
			#add it to the dictionary, key is the state name
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
		if initial_state:
			initial_state.Enter()
			current_state = initial_state

func _process(delta):
	if current_state: #if there is a state
		current_state.Update(delta)
		print(current_state)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
		
	new_state.Enter()
	current_state = new_state
