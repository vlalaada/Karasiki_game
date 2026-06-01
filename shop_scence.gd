extends Node2D

func _ready():
	
	$ButtonGoEvening.hide() 
	
	
	update_ui()

func _on_cake_pressed():
	
	GameState.happiness += 15
	GameState.energy += 10
	
	
	update_ui()
	
	
	$ButtonGoEvening.show()

func update_ui():
	$ВеселаяДевочка/Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBarEnergy.value = GameState.energy
	$ВеселаяДевочка/Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBarHappiness.value = GameState.happiness


func _on_button_go_evening_pressed():
	get_tree().change_scene_to_file("res://scence/EveningScence.tscn")
