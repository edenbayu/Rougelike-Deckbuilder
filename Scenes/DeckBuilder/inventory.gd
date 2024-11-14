class_name Inventory
extends GridContainer

func get_inventory_data():
	var card_datas = GameData.inventory.discarded_cards
	var slots = self.get_children()
	
	# Ensure we don't exceed the bounds of card_datas or slots
	for i in range(min(card_datas.size(), slots.size())):
		if card_datas[i]:
			slots[i].id = i
			slots[i].card_name = card_datas[i].name
			slots[i].card_description = card_datas[i].description
			slots[i].card_texture = card_datas[i].texture
			slots[i].price = int(card_datas[i].price)
			slots[i].status = card_datas[i].status
	#print(card_datas)
