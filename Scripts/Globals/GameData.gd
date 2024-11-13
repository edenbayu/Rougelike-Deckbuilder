extends Node

const gamedata = "res://GameData/GameData.json"
var datas = {
	"gold" = clamp(10000, 0, 999999),
	"shop_cards" = [
		{
			"id" : 1,
			"name" : "pistol",
			"description" : "Lorem Ipsum Doloret",
			"texture" : "res://Assets/Cards/nimbu.png",
			"price" : 500,
		},
		{
			"id" : 2,
			"name" : "sniper",
			"description" : "Lorem Ipsum Doloret",
			"texture" : "res://Assets/Cards/sniper_rare.png",
			"price" : 4000,
		},
		{
			"id" : 3,
			"name" : "katana",
			"description" : "Lorem Ipsum Doloret",
			"texture" : "res://Assets/Cards/katana_rare.png",
			"price" : 2500
		}
	]
}

var inventory = {
	"discarded_cards" = [
	]
}
func load_gold_data() -> int:
	var file = FileAccess.open(gamedata, FileAccess.READ)
	var content = file.get_as_text()
	var data = JSON.parse_string(content)
	var gold = data["gold"]
	
	return gold

func load_shop_cards_data():
	var file = FileAccess.open(gamedata, FileAccess.READ)
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	var datas = json["shop_cards"]
	
	var cards = []
	for data in datas:
		cards.append(data)
	
	return cards

func save_data(new_gold_amount: int) -> void:
	var file = FileAccess.open(gamedata, FileAccess.READ)
	var data = file.get_as_text()
	var json_data = JSON.parse_string(data)
	file.close()
	json_data.gold = new_gold_amount
	 
	file = FileAccess.open(gamedata, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(json_data))
		file.close()
		print("Gold amount updated successfully!")
	else:
		print("Failed to open file for writing.")
	
	#for item in json_data:
		#if item.id == current_saving_id:
			#item.id_level = new_id_level
			#item.last_saved_time = get_new_date()
			#item.level_status = new_level_status
			#break
	#file = FileAccess.open(savedata, FileAccess.WRITE)
	#file.store_line(JSON.stringify(json_data))
	#file.close
	#print("data berhasil disimpan! na")
