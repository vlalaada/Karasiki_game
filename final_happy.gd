extends Node2D


@onready var message_label = $Label


func _ready():
	$AnimatedSprite2D.play("happy")
	$AnimatedSprite2D2.play("conf")
	$AnimatedSprite2D3.play("conf")
	
	
	show_victory_text()
	update_ui()
func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness
func show_victory_text():
	var text = "Блестящий финал!\n"+"Ты умело распорядился\n"+"ресурсами и при\n"+"этом не забыл про\n"+"веселье.\n"+"Ты — организатор\n"+"высшего уровня!"
	
	
	message_label.text = text
	message_label.visible_characters = 0
	
	
	for i in range(text.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout
