extends Control

var isOpen : bool = true
@onready var slots = preload("res://Scene/gui/slot_gui.tscn")

@onready var grid = $NinePatchRect/GridContainer

signal opened
signal closed

func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
	
func _ready():
	for i in range(20):
		var slot = slots.instantiate()
		grid.add_child(slot)
