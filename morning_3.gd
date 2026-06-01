extends Node2D

func _ready():
	
	$ButtonToEvening.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Подарок/GiftButton".disabled = true
	$"Смайлик/SmileButton".disabled = true


func _on_smile_button_pressed():
	lock_choices()
	GameState.update_stats(0, 0, -5)
	update_ui()
	
	$ButtonToEvening.visible = true


func _on_gift_button_pressed():
	lock_choices()
	GameState.update_stats(-200, 0, +10)
	update_ui()
	
	
	get_tree().change_scene_to_file("res://scence/Переход3.tscn")


func _on_button_to_evening_pressed():
	get_tree().change_scene_to_file("res://scence/Evening3.tscn")
