extends Node2D

var total_collected = 0
var goal = 200

@onready var sum_label = $Label
@onready var next_button = $ButtonEvening
@onready var retry_button = $ButtonRetry
@onready var message_label = $"Корги/Label2"
@onready var corgi_node = $"Корги"

func _ready():
	sum_label.text = "Собрано: 0 / 200"
	next_button.visible = false
	retry_button.visible = false
	message_label.visible = false
	corgi_node.visible = false
	
	$Area2D9.area_entered.connect(_on_envelope_area_entered)

# Функция для эффекта печатающегося текста
func show_message(text):
	message_label.text = text
	message_label.visible_characters = 0 
	message_label.visible = true
	corgi_node.visible = true 
	
	var length = text.length()
	for i in range(length + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout 

func _on_envelope_area_entered(area):
	if area.has_method("get_value"):
		var val = area.get_value()
		total_collected += val
		
		sum_label.text = "Собрано: " + str(total_collected) + " / 200"
		area.call_deferred("queue_free")
		
		if total_collected == goal:
			show_next_button()
			show_message("Ура! Твой метод счета работает безупречно\n"+"и теперь ты можешь отправляться в путь за\n"+"новыми открытиями!")
		elif total_collected > goal:
			show_retry_button()
			show_message("Ой, кошелек не закрывается! Кажется, ты\n"+"запутался. Попробуй собрать другие купюры.\n"+"Давай еще разок?")

func show_next_button():
	next_button.visible = true
	retry_button.visible = false

func show_retry_button():
	retry_button.visible = true
	next_button.visible = false

func _on_button_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening3.tscn")

func _on_button_retry_pressed():
	get_tree().reload_current_scene()
