extends TextureRect

const empty_texture = "res://Assets/UI_Elements/slot.png"

var filled : bool = false
signal move
signal fill
 
func _get_drag_data(at_position):
	if filled:
		set_drag_preview(get_preview())
		move.emit()
		
		return self
 
	return null
 
func _can_drop_data(_pos, data):
	return data is TextureRect
 
func _drop_data(_pos, data):
	var temp = self.texture
	self.texture = data.texture
	data.texture = temp
	fill.emit()
 
func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = self.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(112,140)
 
	var preview = Control.new()
	preview.add_child(preview_texture)
 
	return preview
