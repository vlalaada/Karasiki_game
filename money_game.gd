extends Node2D

var total_collected = 0
var goal = 200

@onready var sum_label = $Label
@onready var next_button = $ButtonEvening
@onready var retry_button = $ButtonRetry # Новая кнопка

func _ready():
	sum_label.text = "Собрано: 0 / 200"
	next_button.visible = false
	retry_button.visible = false
	
	$Area2D9.area_entered.connect(_on_envelope_area_entered)

func _on_envelope_area_entered(area):
	if area.has_method("get_value"):
		var val = area.get_value()
		total_collected += val
		
		sum_label.text = "Собрано: " + str(total_collected) + " / 200"
		area.call_deferred("queue_free")
		
		# Логика проверки
		if total_collected == goal:
			# Ровно 200 — победа
			show_next_button()
		elif total_collected > goal:
			# Перебор — предлагаем попробовать снова
			show_retry_button()

func show_next_button():
	next_button.visible = true
	retry_button.visible = false # Прячем кнопку рестарта

func show_retry_button():
	retry_button.visible = true
	next_button.visible = false # Прячем кнопку перехода

# Кнопка "Перейти к вечеру"
func _on_button_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening3.tscn")

# Кнопка "Попробовать снова"
func _on_button_retry_pressed():
	# Просто перезагружаем текущую сцену
	get_tree().reload_current_scene()
