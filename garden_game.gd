extends Node2D


var money = 200


@onready var money_label = $CanvasLayer/Label
@onready var buy_button = $CanvasLayer/BueButton
@onready var water_button = $CanvasLayer/WaterButton
@onready var next_button = $ButtonToNext

@onready var corgi_node = $"Корги"
@onready var message_label = $"Корги/Label"


@onready var seeds_list = [$"Семена", $"Семена2", $"Семена4"]
@onready var carrots_list = [$"Area2D", $"Area2D2", $"Area2D3", $"Area2D4"]

func _ready():
	update_money_label()
	

	for s in seeds_list: s.visible = false
	for m in carrots_list:
		m.visible = false
		m.get_node("CollisionShape2D").disabled = true
	
	water_button.visible = false
	next_button.visible = false
	corgi_node.visible = false
	message_label.visible = false

func update_money_label():
	money_label.text = "Деньги: " + str(money)


func show_victory_message(text):
	corgi_node.visible = true
	message_label.visible = true
	message_label.text = text
	message_label.visible_characters = 0
	
	for i in range(text.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout


func _on_bue_button_pressed():
	if money >= 100:
		money -= 100
		update_money_label()
		for s in seeds_list: s.visible = true
		buy_button.visible = false 
		water_button.visible = true


func _on_water_button_pressed():
	for s in seeds_list: s.visible = false
	for m in carrots_list:
		m.visible = true
		m.get_node("CollisionShape2D").disabled = false 
	water_button.visible = false 


func _on_carrot_pressed(carrot):
	if carrot.visible:
		money += 150
		carrot.visible = false
		carrot.get_node("CollisionShape2D").disabled = true 
		update_money_label()
		check_if_harvest_finished()

func check_if_harvest_finished():
	var all_gone = true
	for m in carrots_list:
		if m.visible:
			all_gone = false
	
	if all_gone:
		next_button.visible = true
		show_victory_message("Ура! Ты отлично распорядился\n"+"деньгами. Ты вложил 100 рублей\n"+"в семена, а получил 700!\n"+"Видишь, как маленькая сумма\n"+"превращается в большую, если\n"+"правильно её использовать?\n")


func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/NextDay3.tscn")


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed: _on_carrot_pressed($Area2D)

func _on_area_2d_2_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed: _on_carrot_pressed($Area2D2)

func _on_area_2d_3_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed: _on_carrot_pressed($Area2D3)

func _on_area_2d_4_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed: _on_carrot_pressed($Area2D4)
