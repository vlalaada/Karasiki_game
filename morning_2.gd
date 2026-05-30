extends Node2D

func _ready():
	# 1. Скрываем кнопку перехода при запуске
	$ButtonToEvening.visible = false
	update_ui()

func update_ui():
	$Утро2/Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Утро2/Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Утро2/Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$Бумага/ButtonPaper.disabled = true
	$КрасныйДжостик/ButtonJost.disabled = true

# Кнопка "ПОМОЧЬ"
func _on_button_paper_pressed():
	lock_choices()
	GameState.update_stats(500, -5, -10)
	update_ui()
	# Кнопка появляется только тут:
	$ButtonToEvening.visible = true

# Кнопка "ПОЙТИ ИГРАТЬ"
func _on_button_jost_pressed():
	lock_choices()
	GameState.update_stats(0, 15, 10)
	update_ui()
	# Пауза для визуального эффекта
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scence/Game.tscn")

# Кнопка "ПЕРЕЙТИ К ВЕЧЕРУ"
func _on_button_to_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening2.tscn")
