extends Control

var MiddlePathUpgrade: Button
var DartMonkeyAbility: Button
var Plasma = false
var Cooldown = false

func _on_click_button_button_down() -> void:
	Global.Balloons += Global.amount_per_click		
			
func _on_balloon_inflater_button_down() -> void:
	if Global.Balloons >= Global.InflatorPrice:
		Global.Balloons = Global.Balloons - Global.InflatorPrice
		Global.InflatorPrice = round(Global.InflatorPrice * 1.2)
		Global.amount_per_click = Global.amount_per_click + Global.InflatorStrength
func _on_dart_button_button_down() -> void:
	if Global.Balloons >= Global.DartMonkeyPrice:
		Global.Balloons = Global.Balloons - Global.DartMonkeyPrice
		Global.DartMonkeyPrice = round(Global.DartMonkeyPrice * 1.2)
		Global.DartMonkeyAmount = Global.DartMonkeyAmount + 1
	if Global.DartMonkeyAmount > 4 && Global.MiddlePathUpgradeUnlock == 0:
		Global.MiddlePathUpgradeUnlock = 1
		dart_middle_function()

func dart_middle_function() -> void:
	MiddlePathUpgrade = Button.new() 
	MiddlePathUpgrade.text = "Increase monkey c/s, Price: 10 MM"
	MiddlePathUpgrade.position = Vector2(7, 400) # Adjust position as needed
	MiddlePathUpgrade.pressed.connect(_on_button_pressed)
	add_child(MiddlePathUpgrade)
	
func dart_ability_function() -> void:
	DartMonkeyAbility = Button.new() 
	DartMonkeyAbility.text = "Activate Supermonkey Fanclub"
	DartMonkeyAbility.position = Vector2(200, 600) # Adjust position as needed
	DartMonkeyAbility.pressed.connect(Ability)
	add_child(DartMonkeyAbility)
	
func Ability() -> void:
	if Cooldown == false:
		Global.DartMonkeySpeed = 5
		if Plasma == true:
			Global.DartMonkeyStrength = 9
		await get_tree().create_timer(5.0).timeout
		Global.DartMonkeySpeed = 0.6
		Global.DartMonkeyStrength = 3
		Cooldown = true
		await get_tree().create_timer(15.0).timeout
		Cooldown = false
func _on_button_pressed() -> void:
	if Global.Balloons >= 10 && Global.MiddlePathUpgradeUnlock == 1:
		Global.MiddlePathUpgradeUnlock = 2
		Global.Balloons -= 10
		Global.DartMonkeySpeed = 0.4
		MiddlePathUpgrade.text = "Increase monkey c/s again, Price: 50 MM"
	elif Global.Balloons >= 50 && Global.MiddlePathUpgradeUnlock == 2:
		Global.MiddlePathUpgradeUnlock = 3
		Global.Balloons -= 50
		Global.DartMonkeySpeed = 0.6
		MiddlePathUpgrade.text = "Triple Damage, Price: 250 MM"
	elif Global.Balloons >= 250 && Global.MiddlePathUpgradeUnlock == 3:
		Global.MiddlePathUpgradeUnlock = 4
		Global.Balloons -= 250
		Global.DartMonkeyStrength = 3
		MiddlePathUpgrade.text = "Supermonkey Fanclub, Price: 1250 MM"
	elif Global.Balloons >= 1250 && Global.MiddlePathUpgradeUnlock == 4:
		Global.MiddlePathUpgradeUnlock = 5
		Global.Balloons -= 1250
		dart_ability_function()
		MiddlePathUpgrade.text = "Plasmamonkey Fanclub, Price: 6250 MM"
	elif Global.Balloons >= 6250 && Global.MiddlePathUpgradeUnlock == 5:
		Global.MiddlePathUpgradeUnlock = 6
		Global.Balloons -= 6250
		DartMonkeyAbility.text = "Activate Plasmamonkey Fanclub"
		Plasma = true
		MiddlePathUpgrade.text = "Paragon Progress 1/3"
		
func _on_dart_monkey_top_path_button_down() -> void:
	if Global.Balloons >= Global.DartMonkeyTopPathPrice:
		Global.Balloons = Global.Balloons - Global.DartMonkeyTopPathPrice		
