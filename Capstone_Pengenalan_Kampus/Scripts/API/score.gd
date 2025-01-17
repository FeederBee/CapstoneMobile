extends Control

@onready var http_request: HTTPRequest = $HTTPRequest

var api_url = "https://example.com/api"  # Ganti dengan URL backend Laravel

func login(nim: String, password: String):
	var headers = ["Content-Type: application/json"]
	var url = api_url + "/login"
	var data = {
		"nim": nim,
		"password": password
	}
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))
	http_request.connect("request_completed", self, "_on_login_response")

func _on_login_response(result, response_code, headers, body):
	if response_code == 200:
		var response = JSON.parse(body.get_string_from_utf8())
		if response["access_token"]:
			Globals.access_token = response["access_token"]  # Simpan token di global
			print("Login successful!")
		else:
			print("Login failed: Invalid response.")
	else:
		print("Login failed: ", response_code)

func send_score(nim: String, name: String, score: int):
	var url = "http://your-laravel-server.test/api/scores"
	var data = {"nim": nim, "name": name, "score": score}
	var headers = ["Content-Type: application/json"]

	# Kirim permintaan HTTP POST
	http_request.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(data))

func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray):
	if response_code == 201:
		print("Score successfully sent!")
	else:
		print("Error sending score: ", response_code)
