extends Node2D

@onready var HeartsContainer = $CanvasLayer/heart_container
@onready var player = $TileMap/Player
# Called when the node enters the scene tree for the first time.
func _ready():
	HeartsContainer.set_max_hearts(player.maxHealth)
	HeartsContainer.update_heart(player.currentHealth)
	player.healthChanged.connect(HeartsContainer.update_heart)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
