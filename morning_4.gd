extends Node2D

func _ready():
	
	$ButtonToEvening.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Колесо/GiftButton2".disabled = true
	$"Купюра/GiftButton".disabled = true


func _on_gift_button_pressed():
	lock_choices()
	GameState.update_stats(500, 0, 0)
	update_ui()
	
	$ButtonToEvening.visible = true


func _on_gift_button_2_pressed():
	lock_choices()
	GameState.update_stats(300, 15, +10)
	update_ui()
	
	
	$ButtonToEvening.visible = true



func _on_button_to_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening3.tscn")
