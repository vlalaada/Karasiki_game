extends Node2D


var budget = 500
var happiness = 0
var items_bought = 0


@onready var shop_panel = $CanvasLayer/ShopPanel
@onready var btn_next = $ButtonToNext
@onready var btn_retry = $ButtonRetry
@onready var corgi = $"Корги"
@onready var message_label = $"Корги/Label"


@onready var shop_buttons = {
	"pizza": $CanvasLayer/ShopPanel/ButtonPizza,
	"cake": $CanvasLayer/ShopPanel/ButtonCake,
	"balloon": $CanvasLayer/ShopPanel/ButtonBalloon,
	"confetti": $CanvasLayer/ShopPanel/ButtonConfetti
}

var shop_data = {
	"pizza":    {"price": 200, "happy": 50, "group_name": "PizzaGroup"},
	"cake":     {"price": 50,  "happy": 30, "group_name": "CakeGroup"},
	"balloon":  {"price": 100, "happy": 20, "group_name": "BallonGroup"},
	"confetti": {"price": 300, "happy": 30, "group_name": "ConfettiGroup"}
}

func _ready():
	
	shop_panel.visible = false
	btn_next.visible = false
	btn_retry.visible = false
	corgi.visible = false
	message_label.visible = false
	$HappinessBar.max_value = 100
	update_ui()


func _on_plus_pressed():
	shop_panel.visible = true

func _on_buy_product(item_id):
	var item = shop_data[item_id]
	var group = get_node_or_null(item.group_name)
	var btn = shop_buttons[item_id]
	
	if group != null:
		
		for sprite in group.get_children():
			sprite.visible = true
			
		
		if btn != null:
			btn.disabled = true
			
		budget -= item.price
		happiness += item.happy
		items_bought += 1
		
		shop_panel.visible = false
		update_ui()
		
		
		if items_bought == 3:
			var plus_node = get_node_or_null("Plus")
			if plus_node: plus_node.disabled = true 
			check_game_result()
	else:
		print("Ошибка: группа " + item.group_name + " не найдена!")

func check_game_result():
	
	corgi.visible = true
	message_label.visible = true
	
	
	if happiness >= 100 and budget > 0:
		message_label.text = "Блестящий результат!\n"+"Максимальное веселье\n"+"при маленьких тратах.\n"+"Друзья в восторге от\n"+"твоего выбора!"
		btn_next.visible = true
	elif happiness >= 100 and budget <0:
		message_label.text = "Все счастливы!Но\n"+"давай подумаем:можно\n"+"ли было купить эти же\n"+"товары так, чтобы не\n"+"остаться в долгу?\n"+"Давай улучшим\n"+"результат!"
		btn_retry.visible = true
	else:
		message_label.text = "Не расстраивайся!\n"+"Попробуй выбрать\n"+"другие предметы,чтобы\n"+"собрать идеальный\n"+"набор для праздника"
		btn_retry.visible = true
	

	animate_text()


func animate_text():
	message_label.visible_characters = 0
	var text_to_show = message_label.text
	
	for i in range(text_to_show.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout


func update_ui():
	var label = $MoneyBar/budget
	label.text = str(budget) + " руб."
	
	if budget < 0:
		label.modulate = Color.RED
	else:
		label.modulate = Color.WHITE
		
	$HappinessBar.value = happiness


func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/переход8.tscn")

func _on_button_retry_pressed():
	get_tree().reload_current_scene()

func _on_пицца_pressed():   _on_buy_product("pizza")
func _on_торттик_pressed(): _on_buy_product("cake")
func _on_шар_pressed():     _on_buy_product("balloon")
func _on_хдопушка_pressed(): _on_buy_product("confetti")
