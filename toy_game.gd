extends Node2D

var caught = 0
var missed = 0
var max_misses = 3
var item_template = preload("res://scence/item.tscn")

@onready var btn_retry = $ButtonRetry
@onready var btn_evening = $ButtonEvening
# Ссылки на новые узлы (убедись, что они созданы в сцене)
@onready var corgi_node = $"Корги"
@onready var message_label = $"Корги/Label"

func _ready():
	btn_retry.visible = false
	btn_evening.visible = false
	corgi_node.visible = false
	message_label.visible = false

func _on_spawner_timeout():
	var item = item_template.instantiate()
	item.position = Vector2(randf_range(50, 950), -50)
	item.caught.connect(_on_item_caught)
	item.missed.connect(_on_item_missed)
	add_child(item)

# Функция для "бегущего" текста
func show_game_over_message(text):
	corgi_node.visible = true
	message_label.visible = true
	message_label.text = text
	message_label.visible_characters = 0
	
	var length = text.length()
	for i in range(length + 1):
		message_label.visible_characters = i
		await get_tree().create_timer(0.05).timeout

func _on_item_caught():
	caught += 1
	$UI/ScoreLabel.text = "Поймано: " + str(caught)

func _on_item_missed():
	missed += 1
	$UI/MissLabel.text = "Пропущено: " + str(missed)
	if missed >= max_misses:
		game_over()

func game_over():
	get_tree().paused = true 
	btn_retry.visible = true  
	btn_evening.visible = true 
	# Запускаем сообщение
	show_game_over_message("Ой! Кажется, ты упустил\n"+"3 монетки. Чтобы заработать\n"+"много денег, нужно\n"+"внимательнее отнестись к\n"+"своему делу! Попробуй ещё\n"+"раз или продолжай свой путь")

func _on_button_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_button_evening_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scence/Evening2.tscn")
