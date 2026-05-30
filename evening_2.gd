extends Node2D

@onready var money_label = $Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney
@onready var energy_bar = $Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar
@onready var happiness_bar = $Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar

@onready var btn_homework = $"Учебники/HomeworkButton"
@onready var btn_sleepover = $"Подушка/SleepoverButton"
@onready var btn_next = $ButtonToNext # Убедись, что путь к кнопке верный

func _ready():
	update_ui()
	
	# Изначально кнопка "Далее" скрыта
	btn_next.visible = false
	
	if GameState.has_made_choice:
		apply_disabled_style()
		btn_next.visible = true # Если выбор уже был сделан, показываем "Далее"

func update_ui():
	money_label.text = str(GameState.money) + " РУБ"
	energy_bar.value = GameState.energy
	happiness_bar.value = GameState.happiness

func apply_disabled_style():
	btn_homework.disabled = true
	btn_sleepover.disabled = true
   

# Логика выбора
func _on_homework_button_pressed():
	if GameState.has_made_choice: return
	GameState.has_made_choice = true
	GameState.update_stats(400, -5, -5)
	
	finalize_choice()

func _on_sleepover_button_pressed():
	if GameState.has_made_choice: return
	GameState.has_made_choice = true
	GameState.update_stats(-200, 15, 20)
	
	finalize_choice()

# Общая функция для завершения выбора
func finalize_choice():
	apply_disabled_style()
	update_ui()
	btn_next.visible = true # Показываем кнопку "Далее"

# Переход в следующую сцену
func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/NextDay2.tscn")
