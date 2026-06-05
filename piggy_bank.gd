extends Area2D

var dragging = false
var offset = Vector2.ZERO
# Задаем фиксированную высоту (Y), где должна ездить свинья
@export var fixed_y: float = 0.0 

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			offset = global_position - get_global_mouse_position()
		else:
			dragging = false

func _process(delta):
	if dragging:
		# Получаем новую позицию мыши
		var mouse_pos = get_global_mouse_position()
		
		# Двигаем только по X, учитывая смещение (offset.x)
		global_position.x = mouse_pos.x + offset.x
		
		# Фиксируем Y, чтобы она не могла двигаться вверх или вниз
		global_position.y = fixed_y
