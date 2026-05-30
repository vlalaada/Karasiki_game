extends Area2D

func _process(_delta):
	# Копилка едет за курсором мыши
	position.x = get_global_mouse_position().x
