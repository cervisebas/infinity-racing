extends Node2D

const game_asset = preload("res://src/game/game.tscn")
const menu_asset = preload("res://src/menu/menu.tscn")

func _ready() -> void:
	append_menu()

func append_menu():
	clear_main()
	var _menu = menu_asset.instantiate()
	_menu.connect("start_game", append_game)
	
	$".".add_child(_menu)

func append_game():
	clear_main()
	var _game = game_asset.instantiate()
	
	$".".add_child(_game)

func clear_main():
	var childs = $".".get_children()
	
	for child in childs:
		$".".remove_child(child)
