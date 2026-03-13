extends VBoxContainer

@onready var balloon_label: Label = $BalloonLabel
var time_elapsed: float = 0.0
const INTERVAL: float = 1.0

@onready var dart_monkey_label: Label = $"../DartMonkeyLabel"
@onready var dart_monkey_price_label: Label = $"../DartMonkeyPriceLabel"


func _on_game_balloons_changed(_amount) -> void:
	update_ui()
	
func _on_game_DartMonkey_changed(_DartMonkeyAmount) -> void:
	update_ui()

func _process(delta: float):
	time_elapsed += delta * Global.DartMonkeySpeed
	if time_elapsed >= INTERVAL:
		time_elapsed -= INTERVAL
		pops_per_second()
func update_ui():
	balloon_label.text = str(Global.Balloons) + " Monkey Money"
	dart_monkey_label.text = str(Global.DartMonkeyAmount) + " Dart Monkey"
	dart_monkey_price_label.text = str(Global.DartMonkeyPrice) + " Monkey Money"
	
func pops_per_second() -> void:
	Global.Balloons = Global.Balloons + Global.DartMonkeyStrength
	update_ui()
