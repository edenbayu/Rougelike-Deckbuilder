class_name ShopCard
extends Control

@onready var card_container = $ShopCardContainer

func spawn_shop_cards(card_datas):
	for card in card_datas:
		#Spawn display cards based on json data.
		var card_display = preload("res://Scenes/DeckBuilder/DisplayCard.tscn")
		card_display = card_display.instantiate()
		card_display.id = card.id
		card_display.card_name = card.name
		card_display.card_description = card.description
		card_display.card_texture = load(card.texture)
		card_display.price = str(card.price)
		card_container.add_child(card_display)
