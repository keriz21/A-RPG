extends CharacterBody2D

@export var SPEED = 300;
@onready var animation = $AnimationPlayer

func handleInput():
	
	var moveDirection = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = moveDirection * SPEED
	pass

func updateAnimation():
	if velocity.length() == 0:
		animation.stop()
	else:
		var direction = "Down"	
		if velocity.x > 0:
			direction = "Right"
		elif velocity.x < 0:
			direction = "Left"
		elif velocity.y < 0:
			direction = "Up"
	
		animation.play("walk" + direction)

func _physics_process(delta):
	handleInput()
	updateAnimation()
	move_and_slide()
	pass
