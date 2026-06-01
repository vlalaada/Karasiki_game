extends Node2D

var score = 0
var misses = 0
var max_misses = 10
var game_active = true
var local_money = 0

# ПЕРЕТАЩИ эти узлы в Инспекторе после сохранения!
@export var piggy_bank :Area2D 
@export var score_label :Label
@export var stats_label :Label
@export var spawn_timer : Timer
@export var to_evening_button : Button
@export var retry_button : Button

func _ready():
	# Безопасное получение денег
	if has_node("/root/GameState"):
		local_money = GameState.money
	
	if to_evening_button: to_evening_button.hide()
	if retry_button: retry_button.hide()
	
	update_score_ui()
	update_stats_display()
	if spawn_timer: spawn_timer.start()

func update_stats_display():
	if stats_label:
		stats_label.text = "Деньги: " + str(local_money)

func _physics_process(delta):
	if not game_active: return
	if piggy_bank:
		var mouse_x = get_global_mouse_position().x
		var screen_width = get_viewport_rect().size.x
		piggy_bank.global_position.x = clamp(mouse_x, 50, screen_width - 50)

func _on_spawn_timer_timeout():
	if not game_active: return
	var coin_scene = preload("res://scence/item.tscn")
	var new_coin = coin_scene.instantiate()
	new_coin.coin_missed.connect(missed_coin)
	var screen_width = get_viewport_rect().size.x
	new_coin.position = Vector2(randf_range(50, screen_width - 50), -50)
	add_child(new_coin)
	if spawn_timer: spawn_timer.start()

func _on_piggy_bank_area_entered(area):
	if not game_active: return
	if area.is_in_group("coin") or "Item" in area.name: 
		score += 1
		update_score_ui()
		area.queue_free()

func missed_coin():
	if not game_active: return
	misses += 1
	update_score_ui()
	if misses >= max_misses:
		game_over()

func update_score_ui():
	if score_label:
		score_label.text = "Поймано: " + str(score) + "\nПропущено: " + str(misses)

func game_over():
	game_active = false
	if spawn_timer: spawn_timer.stop()
	GameState.money = local_money + (score * 10)
	if to_evening_button: to_evening_button.show()
	if retry_button: retry_button.show()

func _on_go_to_evening_button_pressed():
	get_tree().change_scene_to_file("res://evening.tscn")

func _on_retry_button_pressed():
	get_tree().reload_current_scene()
