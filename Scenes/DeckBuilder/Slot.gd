class_name Slot
extends Button

@onready var _texture = $TextureRect

@export_enum("Inventory", "Deck") var slot_type : String

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
		#_texture.filled = status

var hovered = false
var price : int
var card_name : String
var card_description : String

var empty_slot = 	{
		"id" : 0,
		"name" : "",
		"description" : "",
		"texture" : load("res://Assets/UI_Elements/slot.png"),
		"price" : 0,
		"status" : 0
	}

func _on_pressed():
	if status:
		GameData.inventory

func _on_card_moved():
	status = false
	GameData.inventory.discarded_cards[id] = empty_slot

func _on_slot_filled(data):
	print("INI DATA FILLED!", data.card_texture)
	status = true
	var card_data = {
		"id" : id,
		"name" : data.card_name,
		"description" : data.card_description,
		"texture" : data.card_texture,
		"price" : int(data.price),
		"status" : 1
	}
	match slot_type:
		"Inventory":
			print(data.card_texture)
			GameData.inventory.discarded_cards[id] = card_data
		"Deck":
			GameData.inventory.active_cards[id] = empty_slot

func _on_mouse_exited() -> void:
	hovered = true
	self.modulate = Color8(255,255,255, 255)

func on_mouse_entered():
	hovered = false
	if status:
		self.modulate = Color8(165, 165, 165, 255)
	else:
		self.modulate = Color8(255,255,255, 255)

func _get_drag_data(at_position):
	if status:
		set_drag_preview(get_preview())
		_on_card_moved()
		
		return self
 
	return null
 
func _can_drop_data(_pos, data):
	return data is Slot
 
func _drop_data(_pos, data):
	var temp = self.card_texture
	self.card_texture = data.card_texture
	data.card_texture = temp
	_on_slot_filled(data)
 
func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = _texture.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(112,140)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview
