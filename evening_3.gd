extends Node2D

func _ready():
	
	$ButtonToNext.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Бабка/GrandmaButton".disabled = true
	$"Мультики/CartoonsButton".disabled = true


func _on_cartoons_button_pressed():
	lock_choices()
	GameState.update_stats(0, +15, +20)
	update_ui()
	
	$ButtonToNext.visible = true


func _on_grandma_button_pressed():
	lock_choices()
	GameState.update_stats(700, -15, +5)
	update_ui()
	
	get_tree().change_scene_to_file("res://scence/Переход4.tscn")


func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/NextDay3.tscn")
