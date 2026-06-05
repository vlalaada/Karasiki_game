extends Node2D

func _ready():
	
	$ButtonToNext.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Свиня/GrandmaButton".disabled = true
	$"Диско/CartoonsButton".disabled = true


func _on_grandma_button_pressed():
	lock_choices()
	GameState.update_stats(0, 0, 0)
	update_ui()
	
	$ButtonToNext.visible = true


func _on_cartoons_button_pressed():
	lock_choices()
	GameState.update_stats(-500, +20, +25)
	update_ui()

	get_tree().change_scene_to_file("res://scence/переход6.tscn")


func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/переход8.tscn")
