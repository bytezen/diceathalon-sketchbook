extends Node

var Players:Array[PackedScene]

# preload all of the player flags
var flags := [
	preload("res://assets/icons/flags/australia-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/bahamas-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/brazil-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/canada-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/estonia-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/france-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/germany-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/grenada-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/netherlands-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/norway-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/puerto-rico-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/spain-flag-button-square-icon-256.png"),
	preload("res://assets/icons/flags/united-states-of-america-flag-button-square-icon-256.png"),
]

var players := {}

var Player := preload("res://scenes/player.tscn")
var Game : Node

func _ready():
	#temporary data to test somethings 
	#Players.append()
	print("{READY} This is the Singleton GameController!")
	Game = get_tree().get_root()

func add_player(country:String, flag:CompressedTexture2D) -> void:
	#var plyr = players[country]
	if not players.has(country):
		var new_player = Player.instantiate()
		new_player.flag = flag
		new_player.country = country
		players[country] = new_player
		Game.add_child(new_player)
		
	
func _process(_delta: float) -> void:
	if Input.is_action_just_released("left_mouse"):
		print("now I want to dynamically create a player")
		add_player("norway",flags[0])
	pass
	
	
