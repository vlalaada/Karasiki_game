extends Node2D

func _ready():
	# 1. Прячем кнопку перехода в самом начале
	# Используй перетаскивание с Ctrl, чтобы точно вписать путь к твоей кнопке!
	$ButtonGoEvening.hide() 
	
	# 2. Обновляем шкалы при старте
	update_ui()

func _on_cake_pressed():
	# 3. Меняем значения в глобальном хранилище
	GameState.happiness += 15
	GameState.energy += 10
	
	# 4. Обновляем шкалы на экране магазина
	update_ui()
	
	# 5. Показываем кнопку перехода (теперь торт остается на месте)
	$ButtonGoEvening.show()

func update_ui():
	# Чтобы не было ошибок "null instance", используй перетаскивание с Ctrl для этих строк:
	$ВеселаяДевочка/Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBarEnergy.value = GameState.energy
	$ВеселаяДевочка/Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBarHappiness.value = GameState.happiness

# Сигнал от кнопки "Перейти к вечеру"
func _on_button_go_evening_pressed():
	get_tree().change_scene_to_file("res://scence/EveningScence.tscn")
