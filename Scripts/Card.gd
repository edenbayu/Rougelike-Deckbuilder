class_name Card
extends Button

signal sell_card
@export var id : int
@export var card_name : String
@export var card_texture : Texture2D:
	set(value):
		card_texture = value
		if not _texture:
			await ready
		_texture.texture = value

@export var price : String:
	set(value):
		price = value
		if not _label:
			await ready
		_label.text = value

@export var card_description : String:
	set(value):
		card_description = value
		if not _description:
			await ready
		_description.text = value

@export var _texture: TextureRect
@export var _label : Label
@export var _description : RichTextLabel
@export var status: bool

var is_hovered = false
