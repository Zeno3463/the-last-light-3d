extends Node3D

@export var player: Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player.jump_scare_trigger = true
	DialogueManager.show_example_dialogue_balloon(load("res://dialogues/dialogue.dialogue"), "start")
