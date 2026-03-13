extends Control

signal Balloons_changed
signal DartMonkey_changed
var MiddlePathUpgrade: Button

func _on_click_button_button_down() -> void:
	Global.Balloons += Global.amount_per_click
	emit_signal("Balloons_changed", Global.Balloons)
	
func _on_dart_button_button_down() -> void:
	if Global.Balloons >= Global.DartMonkeyPrice:
		Global.Balloons = Global.Balloons - Global.DartMonkeyPrice
		Global.DartMonkeyPrice = round(Global.DartMonkeyPrice * 1.2)
		Global.DartMonkeyAmount = Global.DartMonkeyAmount + 1
		Global.DartMonkeyStrength = Global.DartMonkeyStrength + 1
		emit_signal("Balloons_changed", Global.Balloons)
		emit_signal ("DartMonkey_changed", Global.DartMonkeyAmount)
	if Global.DartMonkeyAmount > 4 && Global.MiddlePathUpgradeUnlock == 0:
		Global.MiddlePathUpgradeUnlock = 1
		my_custom_function()
			

func my_custom_function() -> void:
	MiddlePathUpgrade = Button.new() 
	MiddlePathUpgrade.text = "Increase monkey c/s, Price: 10 MM"
	MiddlePathUpgrade.position = Vector2(7, 400) # Adjust position as needed
	MiddlePathUpgrade.pressed.connect(_on_button_pressed)
	add_child(MiddlePathUpgrade)

func _on_button_pressed() -> void:
	if Global.Balloons >= 10 && Global.MiddlePathUpgradeUnlock == 1:
		Global.MiddlePathUpgradeUnlock = 2
		Global.Balloons -= 10
		Global.DartMonkeySpeed = 0.4
		MiddlePathUpgrade.text = "Increase monkey c/s again, Price: 50 MM"
		emit_signal("Balloons_changed", Global.Balloons)
	elif Global.Balloons >= 50 && Global.MiddlePathUpgradeUnlock == 2:
		Global.MiddlePathUpgradeUnlock = 3
		Global.Balloons -= 50
		Global.DartMonkeySpeed = 0.6
		MiddlePathUpgrade.text = "Triple Damage, Price: 250 MM"
		emit_signal("Balloons_changed", Global.Balloons)
		
			
func _on_balloon_inflater_button_down() -> void:
	if Global.Balloons >= Global.InflatorPrice:
		Global.Balloons = Global.Balloons - Global.InflatorPrice
		Global.InflatorPrice = Global.InflatorPrice * 2
		Global.amount_per_click = Global.amount_per_click + Global.InflatorStrength
		Global.InflatorStrength = Global.InflatorStrength * 2
		emit_signal ("Balloons_changed", Global.Balloons)
		


func _on_dart_monkey_top_path_button_down() -> void:
	if Global.Balloons >= Global.DartMonkeyTopPathPrice:
		Global.Balloons = Global.Balloons - Global.DartMonkeyTopPathPrice
