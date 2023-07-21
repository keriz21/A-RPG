extends CharacterBody2D

@export var SPEED = 300;

func handleInput():
	
	var moveDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moveDirection * SPEED
	pass
	
func _physics_process(delta):
	handleInput()
	move_and_slide()
	pass
