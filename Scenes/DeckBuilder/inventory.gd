class_name Inventory
extends GridContainer

func get_inventory_data():
	var card_datas = GameData.inventory.discarded_cards
	var slots = self.get_children()
	
	# Ensure we don't exceed the bounds of card_datas or slots
	for i in range(min(card_datas.size(), slots.size())):
		if card_datas[i] and not card_datas[i].is_empty():
			slots[i].id = i
			slots[i].card_texture = card_datas[i].texture
			slots[i].status = true
