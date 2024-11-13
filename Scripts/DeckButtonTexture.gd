class_name DeckButtonTexture
extends TextureRect

func on_mouse_entered_deck_button()->void:
	self.modulate = Color8(175,175,175, 255)
	self.material["shader_parameter/width"] = 6.0

func on_mouse_exited_deck_button()->void:
	self.modulate = Color8(255,255,255, 255)
	self.material["shader_parameter/width"] = 0.0
