extends Control
## Controls settings

const games_sensitivities: Dictionary = {
	"Counter Strike 2": 0.022,
	"Apex Legends": 0.022,
	"Team Fortress 2": 0.022,
	"Valorant": 0.07,
}

@onready var game = $HBoxContainer2/Game
@onready var sensitivity = $HBoxContainer2/Sensitivity

func _ready() -> void:
	for sens in games_sensitivities:
		game.add_item(sens)
	var category = DataManager.categories.SETTINGS
	if DataManager.get_data(category, "sensitivity"):
		sensitivity.text = str(DataManager.get_data(category, "sensitivity"))
	if DataManager.get_data(category, "sensitivity_game"):
		game.selected = DataManager.get_data(category, "sensitivity_game")

func _on_sensitivity_text_changed(new_text: String) -> void:
	DataManager.save_data("sensitivity_game", game.get_selected_id(), \
		DataManager.categories.SETTINGS)
	DataManager.save_data("sensitivity_game_value", games_sensitivities.get(game.get_item_text(game.get_selected_id())), \
		DataManager.categories.SETTINGS)
	DataManager.save_data("sensitivity", float(new_text), \
		DataManager.categories.SETTINGS)

func _on_game_item_selected(index: int) -> void:
	DataManager.save_data("sensitivity_game", index, \
		DataManager.categories.SETTINGS)
	DataManager.save_data("sensitivity_game_value", games_sensitivities.get(game.get_item_text(index)), \
		DataManager.categories.SETTINGS)
