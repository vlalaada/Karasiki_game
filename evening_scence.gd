extends Node2D

func _ready():
	# 1. При старте прячем кнопку перехода
	$NextDayButton.visible = false 
	
	# Проверяем, какой был выбор
	if GameState.last_choice == "bought":
		print("Игрок был в магазине, добавляем бонус...")
		GameState.update_stats(0, 0, 0) 
  
	# Обновляем шкалы при старте
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)

# Кнопка "Помочь папе"
func _on_help_dad_button_pressed():
	lock_choices()
	GameState.update_stats(600, -10, -5)
	update_ui()

# Кнопка "Пойти гулять"
func _on_walk_button_pressed():
	lock_choices()
	GameState.update_stats(200, 15, 15)
	update_ui()

# Эта функция делает кнопки неактивными навсегда
func lock_choices():
	$Папа/HelpDadButton.disabled = true
	$Качель/WalkButton.disabled = true
	
	# НОВОЕ: Показываем кнопку для перехода к следующему дню
	$NextDayButton.visible = true

# НОВОЕ: Функция для перехода к следующему дню
func _on_next_day_button_pressed():
	get_tree().change_scene_to_file("res://scence/NextDayScence.tscn")
