extends "res://Scene/collectable/collectable.gd"

@onready var animation = $AnimationPlayer

func collect():
	animation.play("spin")
	await animation.animation_finished
	super.collect()
	pass
	
