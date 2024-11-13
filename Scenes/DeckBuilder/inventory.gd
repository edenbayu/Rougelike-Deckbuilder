extends GridContainer

func get_inventory_data():
	var card_datas = GameData.inventory.discarded_cards
	var slots = self.get_children()
	
	for i in slots:
		var slot = slots[i] as Slot
		if slot:
			slot.card_texture = card_datas[i].texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_inventory_data()
