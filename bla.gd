extends Control

var api_url = "https://karasiki-game.onrender.com/ask-bot"

@onready var http_request = $HTTPRequest
@onready var input_field = $LineEdit
@onready var display_label = $ChatWindow/ScrollContainer/DisplayLabel
@onready var scroll_container = $ChatWindow/ScrollContainer

func _ready():
	# Изначально скрываем всё окно чата
	self.visible = false
	
	if not http_request.request_completed.is_connected(_on_http_request_request_completed):
		http_request.request_completed.connect(_on_http_request_request_completed)

# Кнопка открытия чата
func _on_open_chat_button_pressed():
	self.visible = !self.visible
	if self.visible:
		input_field.grab_focus()

# Кнопка отправки
func _on_button_pressed():
	var user_text = input_field.text
	if user_text == "":
		return

	input_field.text = "" # Очищаем поле сразу
	$DisplayLabel.text = "Бот думает..."
	
	var query = JSON.stringify({"message": user_text})
	var headers = ["Content-Type: application/json"]
	
	http_request.request(api_url, headers, HTTPClient.METHOD_POST, query)

func _on_http_request_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		display_label.text = "Ошибка сети"
		return

	var body_string = body.get_string_from_utf8()

	if response_code == 200:
		var json = JSON.parse_string(body_string)
		if json is Dictionary and json.has("reply"):
			# Мгновенное отображение текста
			$DisplayLabel.text = json["reply"]
			
			# Ждем один кадр, чтобы Label успел пересчитать размер, 
			# и только потом прокручиваем вниз
			await get_tree().process_frame 
			scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
		else:
			display_label.text = "Ошибка формата данных"
	else:
		display_label.text = "Ошибка сервера: " + str(response_code)
