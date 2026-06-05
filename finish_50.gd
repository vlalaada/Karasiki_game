extends Node2D


@onready var message_label = $Label


func _ready():
	$AnimatedSprite2D.play("default")
	
	
	show_victory_text()
	update_ui()
func update_ui():
	$Ui/Panel/VBoxContainer/HBoxContainer/LabelMoney.text = str(GameState.money)
	$Ui/Panel/VBoxContainer/HBoxContainer2/ProgressBar.value = GameState.energy
	$Ui/Panel/VBoxContainer/HBoxContainer3/ProgressBar.value = GameState.happiness
func show_victory_text():
	var text = "Результат впечатляет!\n"+"Твой кошелек полон,\n"+"но отдых прошел не\n"+"так ярко, как мог бы.\n"+"Ты умеешь копить, но\n"+"пора учиться и отдыхать!"
	

	message_label.text = text
	message_label.visible_characters = 0
	

	for i in range(text.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout
