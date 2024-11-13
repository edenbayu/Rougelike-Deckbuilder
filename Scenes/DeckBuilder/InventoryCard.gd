extends TextureRect

const empty_texture = "res://Assets/UI_Elements/slot.png"

var filled : bool = false
 
func _get_drag_data(at_position):
 
	set_drag_preview(get_preview())
 
	return self
 
func _can_drop_data(_pos, data):
	return data is TextureRect
 
func _drop_data(_pos, data):
	var temp = self.texture
	self.texture = data.texture
	data.texture = temp
	filled = true
 
func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = self.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(112,140)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview
