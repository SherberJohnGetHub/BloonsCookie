extends VBoxContainer

@onready var balloon_label: Label = $BalloonLabel
var time_elapsed: float = 0.0
const INTERVAL: float = 1.0

@onready var dart_monkey_label: Label = $"../DartMonkeyLabel"
@onready var dart_monkey_price_label: Label = $"../DartMonkeyPriceLabel"


func _process(delta: float):
	update_ui()
	time_elapsed += delta * Global.DartMonkeySpeed
	if time_elapsed >= INTERVAL:
		time_elapsed -= INTERVAL
		clicks_per_second()
		
func update_ui():
	balloon_label.text = str(Global.Balloons) + " Monkey Money"
	dart_monkey_label.text = str(Global.DartMonkeyAmount) + " Dart Monkey"
	dart_monkey_price_label.text = str(Global.DartMonkeyPrice) + " Monkey Money"
	
func clicks_per_second() -> void:
	Global.Balloons = Global.Balloons + Global.DartMonkeyAmount * Global.DartMonkeyStrength
