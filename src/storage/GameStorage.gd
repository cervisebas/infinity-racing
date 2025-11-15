class_name GameStorage
extends Node

const save_path := GameSettings.StoragePath

var data := {
	"score": 0
}

func save_file():
	var json_string := JSON.stringify(data)
	
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return
	
	file_access.store_line(json_string)
	file_access.close()
	
func load_file():
	if not FileAccess.file_exists(save_path):
		return
		
	var file_access := FileAccess.open(save_path, FileAccess.READ)
	var json_string := file_access.get_line()
	file_access.close()

	var json := JSON.new()
	var error := json.parse(json_string)
	
	if error:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
	
	data = json.data

func save_score(score: int):
	data.score = score
	save_file()
	
func get_score():
	load_file()
	return data.score
