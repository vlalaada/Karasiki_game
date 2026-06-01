extends Node2D


var budget = 350
var required_items = ["Яблоко", "Молоко", "Хлеб", "Морковь"]
var collected_items = []


@onready var budget_label = $budget
@onready var next_button = $ButtonToNext
@onready var retry_button = $ButtonRetry


func _ready():
	
	budget_label.text = "Бюджет:\n" + str(budget) + " руб"
	next_button.visible = false
	retry_button.visible = false
	
	
	
	$"Яблоко/AppleButton" .pressed.connect(on_item_clicked.bind("Яблоко", 50))
	$"Морковь/CarrotButton" .pressed.connect(on_item_clicked.bind("Морковь", 100))
	$"Молоко/MilkButton".pressed.connect(on_item_clicked.bind("Молоко", 100))
	$"Хлеб/BreadButton".pressed.connect(on_item_clicked.bind("Хлеб", 100))
	
	
	$"Медведь/BearButton".pressed.connect(on_item_clicked.bind("Медведь", 300))
	$"Торттик/CakeButton".pressed.connect(on_item_clicked.bind("Торт", 150))
	$"ФутбольныйМяч/BallButton".pressed.connect(on_item_clicked.bind("Мяч", 250))

func on_item_clicked(item_name, price):
	
	if item_name in collected_items:
		return
	
	
	budget -= price
	budget_label.text = "Бюджет:\n" + str(budget) + " руб"
	collected_items.append(item_name)
	
	
	if collected_items.size() == 4:
		validate_shopping()

func validate_shopping():
	
	var all_correct = true
	for item in collected_items:
		if item not in required_items:
			all_correct = false
	
	
	if all_correct and budget >= 0:
		
		next_button.visible = true
		retry_button.visible = false
	else:
	   
		retry_button.visible = true
		next_button.visible = false


func _on_button_retry_pressed():
	get_tree().reload_current_scene()

func _on_button_to_next_pressed():
	
	GameState.update_stats(600, -10, -5)
	get_tree().change_scene_to_file("res://scence/NextDayScence.tscn")
