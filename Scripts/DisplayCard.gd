class_name DisplayCard
extends Button

@export var angle_x_max: float = 15.0
@export var angle_y_max: float = 15.0

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

var tween_rot: Tween
var tween_hover: Tween
var tween_destroy: Tween
var tween_handle: Tween
var tween_steady: Tween

signal hovered
signal clicked
signal purchasementStatus(new_gold_amount, status)
signal purchasementFailed

@onready var _texture := $CardTexture
@onready var _description := $Description/DescriptionText
@onready var _label := $Buy/Label

func _ready():
	angle_x_max = deg_to_rad(angle_x_max)
	angle_y_max = deg_to_rad(angle_y_max)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

##Handle card's hovering effects##
func _on_gui_input(event: InputEvent) -> void:
	#Get local mouse pos
	var mouse_pos: Vector2 = get_local_mouse_position()
	var diff: Vector2 = (position + size) - mouse_pos

	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)

	var rot_x: float = rad_to_deg(lerp_angle(-angle_x_max, angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	
	self._texture.material.set_shader_parameter("x_rot", rot_y)
	self._texture.material.set_shader_parameter("y_rot", rot_x)

##Shows card's description and scale up cards on hover
func _on_mouse_entered() -> void:
	hovered.emit()
	if not disabled:
		$Description.visible = true
		if tween_hover and tween_hover.is_running():
			tween_hover.kill()
		tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC).set_parallel(true)
		tween_hover.tween_property(_texture, "scale", Vector2(1.2, 1.2), 0.5)
		tween_hover.tween_property(_texture, "position", Vector2(_texture.position.x, _texture.position.y -80), 0.5)

func _on_mouse_exited() -> void:
	$Description.visible = false
	_texture.position.y = 0
	
	## Reset rotation
	if tween_rot and tween_rot.is_running():
		tween_rot.kill()
	tween_rot = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween_rot.tween_property(_texture.material, "shader_parameter/x_rot", 0.0, 0.5)
	tween_rot.tween_property(_texture.material, "shader_parameter/y_rot", 0.0, 0.5)
	
	# Reset scale
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(_texture, "scale", Vector2.ONE, 0.55)
	
func _on_buy_button_hovered() -> void:
	hovered.emit()

#Check if a card is buyable or no. Do the purchasment if gold is sufficient. 
func _on_buy_button_clicked() -> void:
	clicked.emit()
	var card_price = int(self.price)
	#Check if gold is sufficient to buy the cards and if the inventory slot isn't full
	if GameData.inventory.discarded_cards.size() > 5:
		var new_amount_gold = GameData.datas.gold
		purchasementStatus.emit(new_amount_gold, "full_slot")
	elif GameData.datas.gold >= card_price:
		GameData.datas.gold -= card_price
		
		#Add the card into inventory after purchasment successfully done.
		var card_data = {
			"id" : self.id,
			"name" : self.name,
			"description" : self.card_description,
			"texture" : self.card_texture,
			"price" : int(self.price)/2
		}
		GameData.inventory.discarded_cards.append(card_data)
		var new_amount_gold = GameData.datas.gold
		purchasementStatus.emit(new_amount_gold, "success")
	else:
		var new_amount_gold = GameData.datas.gold
		purchasementStatus.emit(new_amount_gold, "failed")
