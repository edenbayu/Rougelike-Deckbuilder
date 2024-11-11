class_name Deck
extends Button

@onready var _texture := $Texture
const spawn_numbers := 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

##Function to spawn x cards randomly from Deck into hand
func spawn_card(number)->void:
	for i in range(number):
		print("spawn card!")
		#var card_scene = preload("res://Card.gd")
		#var card = card_scene.instantiate()
		#hands.add_child(card)

func on_deck_pressed():
	spawn_card(spawn_numbers)
