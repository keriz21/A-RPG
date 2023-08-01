extends CharacterBody2D

@export var SPEED = 300;
@onready var animation = $AnimationPlayer
@onready var effect = $Effects
@onready var hurtTimer = $hurtTimer
@onready var hurtBox = $hurtBox

@export var maxHealth : int = 3
@onready var currentHealth : int = maxHealth

@export var knockbackPower = 500

var isHurt : bool = false
var enemyCollision = []

signal healthChanged

func _ready():
	effect.play("RESET")

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
	
	if !isHurt:
		for area in hurtBox.get_overlapping_areas():
			if area.name == "hitBox":
				hurt_by_enemy(area)
	
	pass

func hurt_by_enemy(area):
	currentHealth -= 1
	if currentHealth < 0:
		currentHealth = maxHealth
		
	healthChanged.emit(currentHealth)
	knockback(area.get_parent().velocity)
	effect.play("hurtBlink")
	hurtTimer.start()
	isHurt = true
	await hurtTimer.timeout
	effect.play("RESET")
	isHurt = false


func _on_hurt_box_area_entered(area):
	if area.has_method("collect"):
		area.collect()
	pass # Replace with function body.
	
func knockback(enemyVelocity):
	var knockbackDirection = -velocity
	velocity = (enemyVelocity - velocity).normalized() * knockbackPower
	move_and_slide()
	pass


func _on_hurt_box_area_exited(area):
	pass # Replace with function body.
