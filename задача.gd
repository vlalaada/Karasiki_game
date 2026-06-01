extends Node2D

@onready var input_field = $MoneyInput
@onready var next_button = $ButtonEvening
@onready var retry_button = $ButtonRetry

func _on_check_button_pressed():
	# Получаем текст из поля ввода и превращаем в число
	var user_input = input_field.text.to_int()
	
	
	next_button.visible = false
	retry_button.visible = false
	
	
	if user_input == 100:
		next_button.visible = true
		input_field.editable = false # Запрещаем менять число, если оно верно
	else:
		retry_button.visible = true

func _on_button_retry_pressed():
	retry_button.visible = false
	input_field.text = "" # Очищаем поле для новой попытки

func _on_button_evening_pressed():
	# Переход на следующую сцену
	get_tree().change_scene_to_file("res://scence/NextDay2.tscn")
