extends Area2D

signal caught
signal missed

@export var speed = 300

func _physics_process(delta):
	position.y += speed * delta
	if position.y > 600:
		missed.emit()
		queue_free()

func _on_area_entered(body):
	print("столкновние",body.name)
	if body.is_in_group("Player"):
		caught.emit()
		queue_free()
