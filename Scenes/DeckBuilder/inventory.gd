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
			slots[i].card_description = card_datas[i].card_description
			slots[i].card_texture = card_datas[i].card_texture
			slots[i].price = int(card_datas[i].price) / 2
			slots[i].status = true

func _process(delta: float) -> void:
	update_inventory_data()

func update_inventory_data():
	var datas = self.get_children()
	for data in datas:
		print(data.id, data.card_name)
