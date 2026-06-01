extends Node2D

func _ready():
	
	$Label2/NextDayButton.visible = false
	update_ui()

func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

func lock_choices():
	$"Качель/WalkButton".disabled = true
	$"Папа/HelpDadButton".disabled = true


func _on_walk_button_pressed():
	lock_choices()
	GameState.update_stats(200, +15, +15)
	update_ui()
	
	$Label2/NextDayButton.visible = true


func _on_help_dad_button_pressed():

	get_tree().change_scene_to_file("res://scence/Переход2.tscn")


func _on_next_day_button_pressed():
	get_tree().change_scene_to_file("res://scence/NextDayScence.tscn")
