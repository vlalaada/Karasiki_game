extends Node2D

func _ready():
	# 1. Запускаем анимацию при старте сцены (твое условие)
	$AnimatedSprite2D.play("idle")
	$AnimatedSprite2D2.play("cat")
	
	# 2. Обновляем данные из GameState при входе в новую сцену
	update_ui()

func update_ui():
	# Прописываем пути к твоим элементам интерфейса
	# Если пути другие, перетащи узлы с Ctrl, как мы обсуждали раньше
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

# Если нужно, здесь можно добавить кнопку перехода дальше
func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/Morning2.tscn")
