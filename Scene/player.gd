extends CharacterBody2D

@export var SPEED = 300;
@onready var animation = $AnimationPlayer

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth

@export var knockbackPower = 500

signal healthChanged

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


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox":
		currentHealth -= 1
		if currentHealth < 0:
			currentHealth = maxHealth
			
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().velocity)
	pass # Replace with function body.
	
func knockback(enemyVelocity):
	var knockbackDirection = -velocity
	velocity = (enemyVelocity - velocity).normalized() * knockbackPower
	move_and_slide()
	pass
