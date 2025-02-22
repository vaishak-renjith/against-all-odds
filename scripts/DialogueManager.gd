extends Node

@onready var textBoxScene = preload("res://textbox.tscn")

var dialogueLines: Array[String] = []
var currentLineIndex = 0

var textBox
var textBoxPosition : Vector2

var isDialogueActive = false
var canAdvanceLine = false

var speaker : Node2D

func start_dialogue(position : Vector2, lines: Array[String]):
	if isDialogueActive:
		return
	dialogueLines = lines
	textBoxPosition = position
	_showTextBox()
	
	isDialogueActive = true

func _showTextBox():
	textBox = textBoxScene.instantiate()
	textBox.scale = Vector2(0.25, 0.25)
	textBox.finishedDisplaying.connect(onTextBoxFinishedDisplaying)
	get_tree().root.add_child(textBox)
	textBox.global_position = textBoxPosition
	textBox.displayText(dialogueLines[currentLineIndex])
	canAdvanceLine = false

func onTextBoxFinishedDisplaying():
	canAdvanceLine = true
	
func _unhandled_input(event):
	if (event.is_action_pressed("advance_dialogue") && isDialogueActive && canAdvanceLine):
		textBox.queue_free()
		currentLineIndex += 1
		if (currentLineIndex >= dialogueLines.size()):
			isDialogueActive = false
			currentLineIndex = 0
			return
		_showTextBox()
