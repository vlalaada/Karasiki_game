extends Node2D

var budget = 350
var required_items = ["Яблоко", "Молоко", "Хлеб", "Морковь"]
var collected_items = []

@onready var budget_label = $budget
@onready var next_button = $ButtonToNext
@onready var retry_button = $ButtonRetry
@onready var message_label = $Label
@onready var corgi_node = $"Корги"


@onready var product_nodes = {
	"Яблоко": $Яблоко,
	"Морковь": $Морковь,
	"Молоко": $Молоко,
	"Хлеб": $Хлеб,
	"Медведь": $Медведь,
	"Торт": $Торттик,
	"Мяч": $ФутбольныйМяч
}

func _ready():
	
	corgi_node.visible = false
	message_label.visible = false
	next_button.visible = false
	retry_button.visible = false
	
	budget_label.text = "Бюджет:\n" + str(budget) + " руб"
	
	
	$Яблоко/AppleButton.pressed.connect(on_item_clicked.bind("Яблоко", 50))
	$Морковь/CarrotButton.pressed.connect(on_item_clicked.bind("Морковь", 100))
	$Молоко/MilkButton.pressed.connect(on_item_clicked.bind("Молоко", 100))
	$Хлеб/BreadButton.pressed.connect(on_item_clicked.bind("Хлеб", 100))
	
	$Медведь/BearButton.pressed.connect(on_item_clicked.bind("Медведь", 300))
	$Торттик/CakeButton.pressed.connect(on_item_clicked.bind("Торт", 150))
	$ФутбольныйМяч/BallButton.pressed.connect(on_item_clicked.bind("Мяч", 250))

func on_item_clicked(item_name, price):
	if item_name in collected_items:
		return
	
	
	if product_nodes.has(item_name):
		product_nodes[item_name].hide() 
	
	
	budget -= price
	budget_label.text = "Бюджет:\n" + str(budget) + " руб"
	collected_items.append(item_name)
	
	
	if collected_items.size() == 4:
		validate_shopping()


func play_text_animation(text_to_show):
	message_label.text = text_to_show
	message_label.visible_characters = 0 
	
	var length = text_to_show.length()
	for i in range(length + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout 

func validate_shopping():
	var all_correct = true
	for item in collected_items:
		if item not in required_items:
			all_correct = false
	
	
	corgi_node.visible = true
	message_label.visible = true
	
	if all_correct and budget >= 0:
		play_text_animation("Поздравляю! Твоя мечта стала\n"+"ещё ближе, потому что ты умеешь\n"+"тратить деньги с умом.Продолжай\n"+"в том же духе!")
		next_button.visible = true
		retry_button.visible = false
	else:
		play_text_animation("Ой-ой! Кажется, в корзинке\n"+"оказались не все нужные\n"+"продукты.Помнишь, папа просил\n"+"купить только то,что записано\n"+"в списке? Попробуй ещё раз,\n"+"будь внимательнее к списку,\n"+"и у тебя всё обязательно\n"+"получится!")
		retry_button.visible = true
		next_button.visible = false

func _on_button_retry_pressed():
	get_tree().reload_current_scene()

func _on_button_to_next_pressed():
	GameState.update_stats(600, -10, -5)
	get_tree().change_scene_to_file("res://scence/NextDayScence.tscn")
