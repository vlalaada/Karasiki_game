extends Node2D

# Например: $ТекстовоеОблачко/Label
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
	var text = "Кажется, расчеты\n"+"оказались слишком\n"+"сложными. Ты не смог\n"+"накопить нужную сумму\n"+"к концу срока. Не\n"+"расстраивайся — \n"+"попробуй изменить\n"+"свою стратегию!"
	
	# Настраиваем Label
	message_label.text = text
	message_label.visible_characters = 0
	
	# Цикл печатной машинки
	for i in range(text.length() + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout
