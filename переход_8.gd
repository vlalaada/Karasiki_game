extends Node2D

@onready var message_label = $Label 
@onready var btn_result = $ButtonToEvening

func _ready():
	btn_result.visible = false
	# Запускаем "печатную машинку"
	show_welcome_message()

func show_welcome_message():
	var text = "Ты проделал большую\n"+"работу и отлично\n"+"постарался! Поскорее\n"+"узнай свой результат за\n"+"четыре дня."
	message_label.text = text
	message_label.visible_characters = 0
	
	for i in range(text.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout
		
	btn_result.visible = true

# --- ЛОГИКА ПЕРЕХОДА К КОНЦОВКАМ ---
func _on_button_to_evening_pressed():
	var next_scene = ""
	
	# ПРОВЕРКА УСЛОВИЙ
	if GameState.money >= 5500:
		if GameState.happiness >= 30 and GameState.energy >= 30:
			# Идеальный финал: много денег + хорошие параметры
			next_scene = "res://scence/FinalHappy.tscn"
		else:
			# Компромиссный финал: много денег, но не хватает параметров
			next_scene = "res://scence/Finish50.tscn"
	else:
		# Финал при нехватке денег
		next_scene = "res://scence/FinalSad.tscn"
	
	# Переход
	get_tree().change_scene_to_file(next_scene)
