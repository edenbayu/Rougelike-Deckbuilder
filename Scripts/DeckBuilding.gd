class_name DeckBuilding
extends Node2D

var sound_manager = preload("res://Scenes/sound_manager.tscn")
@onready var panel = $CanvasLayer/DeckShow
@onready var deck_button = $CanvasLayer/Shop/DeckContainer/DeckButton
@onready var gold  = $CanvasLayer/Shop/GoldLabel
@onready var shop_cards : ShopCard = $CanvasLayer/Shop
@onready var inventory : Inventory = $CanvasLayer/DeckShow/Panel/Modal/Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	##configure cards and ui elements
	var display_card_data = GameData.load_shop_cards_data()
	shop_cards.spawn_shop_cards(display_card_data)
	gold.text = str(GameData.load_gold_data())
	panel.position = Vector2(0, 1080)
	
	##Instantiate the sound manager
	sound_manager = sound_manager.instantiate()
	add_child(sound_manager)
	sound_manager.bgm_menu_music()
	
	##connects each card from shop display to the sound_manager
	for card in get_node("CanvasLayer/Shop/ShopCardContainer").get_children():
		var display_card = card as DisplayCard
		if display_card:
			card.connect("hovered", on_card_display_hovered)
			card.connect("clicked", on_card_display_clicked)
			card.connect("purchasementStatus", on_successful_purchasement)

func _process(delta: float) -> void:
	var new_amount = GameData.datas.gold
	gold.text = str(new_amount)

##UI Interaction codes##

func on_card_display_hovered():
	sound_manager.hover_card_sound()

func on_card_display_clicked():
	sound_manager.click_button_sound()

func on_deck_button_hovered():
	sound_manager.hover_button_sound()

func on_deck_button_clicked():
	deck_button.disabled = true
	sound_manager.click_button_sound()
	inventory.get_inventory_data()
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween.tween_property(panel, "position", Vector2(panel.position.x, 0), 1)

func close_deck():
	deck_button.disabled = false
	sound_manager.click_button_sound()
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK).set_parallel(true)
	tween.tween_property(panel, "position", Vector2(panel.position.x, 1080), 1)
## End of User Interface signals code##

## Handle Purchasment signal##
func on_successful_purchasement(status) -> void:
	match status:
		"success":
			Warning.display_warning_text("Successful", get_global_mouse_position(),shop_cards)
		"failed":
			Warning.display_warning_text("Insufficient amount of gold!", get_global_mouse_position(),shop_cards)
		"full_slot":
			Warning.display_warning_text("Inventory is full!", get_global_mouse_position(),shop_cards)
