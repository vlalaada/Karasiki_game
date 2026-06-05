extends Node2D

func _ready():
	
	$ButtonToEvening.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Купюра/GiftButton".disabled = true
	$"Колесо/GiftButton2".disabled = true


func _on_gift_button_pressed():
	lock_choices()
	GameState.update_stats(+1000, 0, 0)
	update_ui()
	
	$ButtonToEvening.visible = true


func _on_gift_button_2_pressed():
	lock_choices()
	GameState.update_stats(+1500, 15, +10)
	update_ui()
	
	
	get_tree().change_scene_to_file("res://scence/переход7.tscn")


func _on_button_to_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening4.tscn")
