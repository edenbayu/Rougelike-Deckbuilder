class_name SlotCard
extends PanelContainer

@export_enum("INVENTORY", "DECK") var slot_type = "INVENTORY"
@export var id: int

var filled = false

var empty_slot = {
		"id" : 0,
		"name" : "",
		"description" : "",
		"texture" : load("res://Assets/UI_Elements/slot.png"),
		"price" : 0,
		"status" : 0
	}

func _on_area_2d_body_entered(body) -> void:
	var data = body.get_parent()
	if not filled:
		data.is_inside_dropable = true
		data.body_ref = self
	var card_data = {
		"id" : data.id,
		"name" : data.card_name,
		"description" : data.card_description,
		"texture" : data.card_texture,
		"price" : int(data.price),
		"status" : 1
	}

	match slot_type:
		"INVENTORY":
			GameData.inventory.discarded_cards[id] = card_data
		"DECK":
			GameData.inventory.active_cards[id] = card_data

func _on_area_2d_body_exited(body: Node2D) -> void:
	filled = false
	match slot_type:
		"INVENTORY":
			GameData.inventory.discarded_cards[id] = empty_slot
		"DECK":
			GameData.inventory.active_cards[id] = empty_slot
