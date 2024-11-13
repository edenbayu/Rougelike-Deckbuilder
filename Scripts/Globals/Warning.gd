extends Node2D

var display_text_z_order : int = 20
func display_warning_text(message: String, position: Vector2, parent) -> void:
	var number = Label.new()
	number.global_position = position
	number.text = str(message)
	number.z_index = display_text_z_order
	number.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	var font = load("res://Assets/Fonts/I-pixel-u.ttf")
	number.label_settings.font_color = color
	number.label_settings.font_size = 40
	number.label_settings.outline_color = "#000"
	number.label_settings.outline_size = 12
	number.label_settings.font = font
	
	parent.call_deferred("add_child", number)
	
	await number.resized
	number.pivot_offset = Vector2(number.size / 2)
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		number, "position:y", number.position.y - 24, 0.25
	).set_ease(Tween.EASE_OUT)
	tween.tween_property(
		number, "position:y", number.position.y, 0.5
	).set_ease(Tween.EASE_IN).set_delay(0.25)
	tween.tween_property(
		number, "scale", Vector2.ZERO, 0.25
	).set_ease(Tween.EASE_IN).set_delay(0.5)

	await tween.finished
	number.queue_free()
