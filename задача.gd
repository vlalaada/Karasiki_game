extends Node2D

@onready var input_field = $MoneyInput
@onready var next_button = $ButtonEvening
@onready var retry_button = $ButtonRetry
@onready var message_label = $Label3
@onready var corgi_node = $"Корги"

func _ready():
	# Прячем всё лишнее при старте
	next_button.visible = false
	retry_button.visible = false
	message_label.visible = false
	corgi_node.visible = false

# Функция для анимации "бегущего" текста
func play_text_animation(text_to_show):
	message_label.text = text_to_show
	message_label.visible_characters = 0 
	message_label.visible = true
	corgi_node.visible = true # Показываем корги вместе с текстом
	
	var length = text_to_show.length()
	for i in range(length + 1):
		message_label.visible_characters = i
		# Скорость печати (0.05 сек на букву)
		await get_tree().create_timer(0.05).timeout 

func _on_check_button_pressed():
	var user_input = input_field.text.to_int()
	
	# Скрываем кнопки перед проверкой
	next_button.visible = false
	retry_button.visible = false
	
	if user_input == 100:
		# ВЫИГРЫШ
		input_field.editable = false
		next_button.visible = true
		play_text_animation("Победа! Твоя копилка стала\n"+"тяжелее, а мечта — еще ближе.\n"+"Ты понял главный секрет: если\n"+"считать по маленьким кусочкам,\n"+"любая большая сумма становится\n"+"простой. Продолжай в том же\n"+"духе!")
	else:
		# ПРОИГРЫШ
		retry_button.visible = true
		play_text_animation("Катя запуталась в покупках!\n"+"Давай ей поможем.Будем\n"+"считать по порядку: сначала\n"+"пирожки, потом торт, а в\n"+"конце — яблоки. Считая по\n"+"маленьким кусочкам, ты точно\n"+"не ошибешься. Давай попробуем\n"+"снова!")

func _on_button_retry_pressed():
	retry_button.visible = false
	message_label.visible = false # Скрываем текст при повторе
	corgi_node.visible = false    # Скрываем корги при повторе
	input_field.text = "" 

func _on_button_evening_pressed():
	get_tree().change_scene_to_file("res://scence/NextDay2.tscn")
