class_name Hands
extends HBoxContainer

 

func _spawn_card(card: Card)->void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var scene = preload("res://Scenes/DeckBuilder/Card.tscn")
	var card = scene.instantiate()
	self.add_child(card)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
