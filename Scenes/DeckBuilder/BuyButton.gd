class_name BuyButton
extends Button

@export var price : String:
	set(value):
		price = value
		if not _label:
			await ready
		_label.text = value

@onready var _label := $Label
