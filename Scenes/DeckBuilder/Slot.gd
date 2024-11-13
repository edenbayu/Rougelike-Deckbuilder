class_name Slot
extends Button

@onready var _texture = $TextureRect

@export var card_texture : Texture2D:
	set(value):
		card_texture = value
		if not _texture:
			await ready
		_texture.texture = value

var status = false
var id : int

func _input_event(event):
	if event is InputEventMouseButton and event.pressed:
		print("Panel clicked!")

func _on_mouse_exited() -> void:
	self.modulate = Color8(255,255,255, 255)

func on_mouse_entered():
	if status:
		self.modulate = Color8(165, 165, 165, 255)
	else:
		self.modulate = Color8(255,255,255, 255)
