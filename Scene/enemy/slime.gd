extends CharacterBody2D

var startPosition
var endPosition

@export var limit = 0.5
@export var speed = 50
@export var endPoint : Marker2D

@onready var animation = $AnimationPlayer

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func change_direction():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd

func update_velocity():
	var moveDirection = endPosition - position
	if moveDirection.length() < limit :
		#endPosition = position
		#moveDirection = Vector2(0,0)
		change_direction()
	
	velocity = moveDirection.normalized() * speed
	
func update_animation():
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
	
func handle_collider():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
#		print_debug(collider.name)
		
#		if(collider.name == "Player"):
#			print_debug(collider.name)
	
func _physics_process(delta):
	update_velocity()
	update_animation()
	handle_collider()
	move_and_slide()
