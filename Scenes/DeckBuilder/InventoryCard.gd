class_name InventoryCard
extends Card

var draggable = false
var is_inside_dropable = false
var body_ref
var offset : Vector2

func _ready() -> void:
	$Sell.visible = false

func _process(delta: float) -> void:
	if draggable:
		position = get_global_mouse_position() - offset

func _on_sell_pressed() -> void:
	GameData.datas.gold += int(price)
	sell_card.emit()
	queue_free()

func _on_Button_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				pass
			MOUSE_BUTTON_RIGHT:
				if $Sell.visible:
					$Sell.visible = false
				else:
					$Sell.visible = true

func _on_button_down() -> void:
	draggable = true
	offset = get_global_mouse_position() - global_position

func _on_button_up() -> void:
	draggable = false
	var tween = get_tree().create_tween()
	if is_inside_dropable:
		tween.tween_property(self, "position", body_ref.get_global_position(), 0.2).set_ease(Tween.EASE_OUT)

func _on_mouse_entered() -> void:
	self.modulate = Color8(165, 165, 165, 255)

func _on_mouse_exited() -> void:
	self.modulate = Color8(255, 255, 255, 255)
