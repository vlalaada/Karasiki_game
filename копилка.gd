extends TextureRect

# Укажи в инспекторе, какой тип этот узел принимает (например, "coin")
@export var accepted_type = "coin" 

func _can_drop_data(_at_position, data):
 # Проверяем, притащили ли мы вообще какой-то предмет
 return typeof(data) == TYPE_DICTIONARY and data.has("type")

func _drop_data(_at_position, data):
 if data["type"] == accepted_type:
  print("Успешно! Предмет доставлен в: ", name)
  data["node"].queue_free() # Предмет исчезает, так как мы его положили
 else:
  print("Сюда нельзя положить этот предмет!")
