extends CanvasLayer

@onready var inventori = $InventoryGui

func _ready():
	inventori.close()

func _input(event):
	if Input.is_action_just_pressed("toggle_inventory"):
		if inventori.isOpen:
			inventori.close()
		else:
			inventori.open()
	pass
