class_name SoundManager
extends Node2D

@onready var hover_audio = $hover
@onready var click_audio = $click
@onready var bgm_menu = $bgm
@onready var hover_card_audio = $hover_card

func hover_button_sound() -> void:
	hover_audio.play()

func click_button_sound() -> void:
	click_audio.play()

func hover_card_sound()->void:
	hover_card_audio.play()

func bgm_menu_music() -> void:
	bgm_menu.stream.loop = true
	bgm_menu.play()
