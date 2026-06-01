extends Node2D

func _ready():
	
	$AnimatedSprite2D.play("cat")
	$AnimatedSprite2D2.play("idle")
	
	
	update_ui()

func update_ui():
	
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Переход/Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness

# 
func _on_button_to_next_pressed():
	get_tree().change_scene_to_file("res://scence/Morning4.tscn")
