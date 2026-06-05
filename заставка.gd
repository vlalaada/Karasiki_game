extends Node2D

@onready var text_label = $Label
@onready var arrow_area = $Area2D
@onready var start_button = $ButtonToEvening

var dialogue = [
  "Привет! Ты мечтаешь о чём-то большом,\n" +"например, о велосипеде,но у тебя\n"+"не хватает средств?",
  "Эта игра научит тебя правильно\n" + "распоряжаться деньгами, оставаясь\n" + "счастливым и энергичным",
  "Твоя задача- на протяжении четырёх\n"+ "дней делать выбор, в результате\n"+"которого ты должен накопить 5500\n"+"рублей на свою мечту",
  "Также ты можешь воспользоваться\n"+"ботом-рыбкой в нижнем углу,\n"+"если тебе нужна помощь или просто\n"+"хочешь пообщаться",
  "Не растеряй по пути счастье и энергию\n" + "Это важно!\n" + "Удачи!"
]

var current_index = 0

func _ready():
  text_label.visible_characters = 0
  start_button.visible = false
  await get_tree().create_timer(1.0).timeout
  show_phrase()

func show_phrase():
  if current_index < dialogue.size():
   var text = dialogue[current_index]
   text_label.text = text
   text_label.visible_characters = 0
   var tween = create_tween()
   tween.tween_property(text_label, "visible_characters", text.length(), text.length() * 0.05)
  else:
   arrow_area.visible = false
   start_button.visible = true
   text_label.text = "Готов начать путь к мечте?"

func _on_area_2d_input_event(_viewport, event, _shape_idx):
  if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
   current_index += 1
   show_phrase()

func _on_button_to_evening_pressed():
  get_tree().change_scene_to_file("res://scence/MorningScence.tscn")
