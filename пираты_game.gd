extends Node2D

@onready var corgi = $"Корги"
@onready var message_label = $"Корги/Label"
@onready var btn_retry = $ButtonRetry 
@onready var btn_evening = $ButtonEvening 

var choice_made = false 

func _ready():
  corgi.visible = false
  message_label.visible = false
  btn_retry.visible = false
  btn_evening.visible = false



func _on_сундук_1_pressed():
  if choice_made: return 
  choice_made = true
  
  show_corgi_message("Жду...")
  await get_tree().create_timer(3.0).timeout
  show_corgi_message("Молодец, ты подождал\n"+"3 секунды и заработал\n"+"50 рублей! В любом\n"+"деле нужно проявлять\n"+"терпение")
  show_final_buttons()

func _on_сундук_2_pressed():
  if choice_made: return
  choice_made = true
  
  var chance = randi() % 2
  if chance == 1:
	show_corgi_message("Ты выбрал риск\n"+"и выиграл 100 рублей-\n"+"тебе повезло!")
  else:
	show_corgi_message("Ты выбрал риск и\n"+"проиграл - тебе не\n"+"повезло.")
  show_final_buttons()

func _on_сундук_3_pressed():
  if choice_made: return
  choice_made = true
  
  show_corgi_message("Ты выбрал стабильность—\n"+"и выиграл 50 рублей\n"+"ты медленнее, но\n"+"надежнее идешь к цели.")
  show_final_buttons()



func show_final_buttons():
 
  await get_tree().create_timer(1.0).timeout
  btn_retry.visible = true
  btn_evening.visible = true

func show_corgi_message(text):
  corgi.visible = true
  message_label.visible = true
  message_label.text = text
  
  message_label.visible_characters = 0
  for i in range(message_label.text.length() + 1):
	message_label.visible_characters = i
	await get_tree().create_timer(0.05).timeout


func _on_button_retry_pressed():
  get_tree().reload_current_scene()

func _on_button_evening_pressed():
  get_tree().change_scene_to_file("res://scence/Evening4.tscn")
