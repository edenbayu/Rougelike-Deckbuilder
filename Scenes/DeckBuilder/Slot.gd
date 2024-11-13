class_name Slot
extends Button

@onready var _texture = $TextureRect

@export var card_texture : Texture2D:
	set(value):
		card_texture = value
		if not _texture:
			await ready
		_texture.texture = value

@export var id : int
var status = false:
	set(value):
		status = value
		_texture.filled = status

var hovered = false
var price : int
var card_name : String
var card_description : String

func _on_pressed():
	if status:
		print("Sell item!")

func _ready() -> void:
	for i in self.get_children():
		i.connect("move", _on_card_moved)
		i.connect("fill", _on_slot_filled)


func _on_card_moved():
	status = false

func _on_slot_filled():
	status = true

func _on_mouse_exited() -> void:
	hovered = true
	self.modulate = Color8(255,255,255, 255)

func on_mouse_entered():
	hovered = false
	if status:
		self.modulate = Color8(165, 165, 165, 255)
	else:
		self.modulate = Color8(255,255,255, 255)


func on_card_sold():
	pass
	
